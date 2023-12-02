Return-Path: <linux-wireless+bounces-326-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BB1801C6E
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Dec 2023 12:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73050B20D34
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Dec 2023 11:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC667493;
	Sat,  2 Dec 2023 11:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=w1.fi header.i=@w1.fi header.b="NMLTDYYg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.w1.fi (mail.w1.fi [212.71.239.96])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D9C18C
	for <linux-wireless@vger.kernel.org>; Sat,  2 Dec 2023 03:29:27 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by mail.w1.fi (Postfix) with ESMTP id 85568115C5;
	Sat,  2 Dec 2023 11:29:25 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at w1.fi
Received: from mail.w1.fi ([127.0.0.1])
	by localhost (mail.w1.fi [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pw7LQ74DMHku; Sat,  2 Dec 2023 11:28:52 +0000 (UTC)
Received: by jm (sSMTP sendmail emulation); Sat, 02 Dec 2023 13:28:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=w1.fi; s=default;
	t=1701516531; bh=HAjiXQeAJyyFes4evo++aSo9ud1EFo2Ky0J/WGZANfE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NMLTDYYg90gbGzP0qynQ/PNgOM0mpGltICFJojIKTL8YUlK5cvjQUopqRxB9heQ5s
	 p/u9kvxJkL8tqwp6YN8WD5NUXS3CAl3ZHr/LZir8jwDEvDac1xsQGAiZ2+jiKnkl5j
	 M7yKrwYblfdsZuWI01WyZYZXwnlJgXGAY6yzv1voQSXlgvmjMhJ3P/M6gTWUxSCx0c
	 DcuFPmdX7mfKfJyy5GFZ5kuoFRZRjiU/l0caSFdnECNkRn4yyIHksrNSnLg063dnGl
	 EFlqH/mIYviip4idV1kEPQMR6lyZ/g0yG24Xd8PpdSme+GxV1jDk11iGcAxUn7pRkO
	 wzM310ZNG9uWg==
Date: Sat, 2 Dec 2023 13:28:49 +0200
From: Jouni Malinen <j@w1.fi>
To: gregory.greenman@intel.com
Cc: johannes@sipsolutions.net, linux-wireless@vger.kernel.org,
	Avraham Stern <avraham.stern@intel.com>
Subject: Re: [PATCH] wifi: mac80211: don't drop all unprotected public action
 frames
Message-ID: <ZWsU8T2c9GHQUsE9@w1.fi>
References: <20231016145213.2973e3c8d3bb.I6198b8d3b04cf4a97b06660d346caec3032f232a@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016145213.2973e3c8d3bb.I6198b8d3b04cf4a97b06660d346caec3032f232a@changeid>

On Mon, Oct 16, 2023 at 02:52:48PM +0300, gregory.greenman@intel.com wrote:
> Not all public action frames have a protected variant. When MFP is
> enabled drop only public action frames that have a dual protected
> variant.

That description sounds accurate..

> diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
> +/**
> + * ieee80211_is_protected_dual_of_public_action - check if skb contains a
> + * protected dual of public action management frame
> + * @skb: the skb containing the frame, length will be checked
> + *
> + * Return: true if the skb contains a protected dual of public action
> + * management frame, false otherwise.
> + */

But this comment and the function name feel quite misleading. This does
not return true if the skb contains a Protected Dual of Public Action
frame; this returns true if the skb contains a Public Action frame for
which a Protected Dual of Public Action frame is defined. Or well, that
is what this function should do for the mac80211 change to work
correctly, but it does not really do that..

> +static inline bool
> +ieee80211_is_protected_dual_of_public_action(struct sk_buff *skb)
> +{
> +	u8 action;
> +
> +	if (!ieee80211_is_public_action((void *)skb->data, skb->len) ||
> +	    skb->len < IEEE80211_MIN_ACTION_SIZE + 1)
> +		return false;
> +
> +	action = *(u8 *)(skb->data + IEEE80211_MIN_ACTION_SIZE);
> +
> +	return action != WLAN_PUB_ACTION_20_40_BSS_COEX &&
> +		action != WLAN_PUB_ACTION_DSE_REG_LOC_ANN &&
> +		action != WLAN_PUB_ACTION_MSMT_PILOT &&
> +		action != WLAN_PUB_ACTION_TDLS_DISCOVER_RES &&
> +		action != WLAN_PUB_ACTION_LOC_TRACK_NOTI &&
> +		action != WLAN_PUB_ACTION_FTM_REQUEST &&
> +		action != WLAN_PUB_ACTION_FTM_RESPONSE &&
> +		action != WLAN_PUB_ACTION_FILS_DISCOVERY;
> +}

What is this list of Public Action frames based on? The "Reserved" rows
of the Protected Dual of Public Action frames from some snapshot of the
IEEE 802.11 standard? That is neither robust nor correct way of doing
this. It would be more robust (in a sense of not breaking things in
future) to make this match against cases for which there is a known
protected variant instead of assuming that there is a protected variant
for everything that is known to not have one yet defined.

Furthermore, this is completely wrong for Vendor Specific Public Action
frames. There is a Protected Vendor Specific value for Protected Dual of
Public Action frame, but that value is used on case by case basis for
each different type of vendor specific frame. In other words, this part
would need to look at the OUI:subtype combination to search which vendor
specific cases have a protected variant. I'd expect there to be a very
limited, if any, such cases, i.e., more or less all vendor specific
Public Action frames should be allowed to be processed in mac80211 even
when MFP has been negotiated for an association.

In practice, this patch (well, a commit in wireless-next.git now) leaves
Vendor Specific Public Action frame cases broken. For example, DPP does
not work correctly with this. hostap.git test case
dpp_conn_status_success_hostapd_configurator can demonstrate that issue.

In addition, this would break more recently added Public Action frames
with Action field values larger than 34 broken. There are quite a few
such frames defined and none of them seem to have a matching protected
dual.

-- 
Jouni Malinen                                            PGP id EFC895FA

