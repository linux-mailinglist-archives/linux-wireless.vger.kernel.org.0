Return-Path: <linux-wireless+bounces-31292-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLgCEZv6emlSAQIAu9opvQ
	(envelope-from <linux-wireless+bounces-31292-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 07:13:47 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4071AAC2AF
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 07:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1092A30046AB
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jan 2026 06:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7733D3783A5;
	Thu, 29 Jan 2026 06:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="N+33e20h"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF03352923;
	Thu, 29 Jan 2026 06:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769667220; cv=none; b=HAP6VWrpkOEbsCh2LfF2iFzb3OeOeyElEMMqQQzXi5iP304dMeWVmVG2CbcNCeqFx/bgBLuLqXd/bHxnxZiWisXbJd6mPfwAtZeFKOM1kmweApiZLfkI7wpSQURFYdytZOPM9MmV7p9trRUfFQpw7/HmzNZavvx46PaEVMYjfrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769667220; c=relaxed/simple;
	bh=LAxJ4r2khmYzrFy0IaJ5OE5g69m/iuKnXCOPaX9F2Hg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UwYqX3OKTSI6q9XPqtXFCNJfXiEp82JvHngfkYxp9xTB4NmeUhhvihOApMKvawIPx4dg9VUgjtpUfgv7XDT+JZdhhJLZlSgQU7Oy4jqvFKhJl3rAcAlHyGJpy0vYCvUKReTWPQFg224xsLk0CwC7vAjvhLbruIp2UP+DfFaWOhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=N+33e20h; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from LAPTOP-N070L597.localdomain (unknown [221.228.238.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3262103f5;
	Thu, 29 Jan 2026 14:13:31 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: jeff.johnson@oss.qualcomm.com
Cc: ath11k@lists.infradead.org,
	baochen.qiang@oss.qualcomm.com,
	jianhao.xu@seu.edu.cn,
	jjohnson@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	zilin@seu.edu.cn
Subject: Re: [PATCH v2] wifi: ath11k: fix memory leaks in beacon template setup
Date: Thu, 29 Jan 2026 06:13:30 +0000
Message-Id: <20260129061330.796429-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <6cc72c12-6f50-4e91-9b7a-bde8633009c4@oss.qualcomm.com>
References: <6cc72c12-6f50-4e91-9b7a-bde8633009c4@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9c0862afff03a1kunme0f4efb7101759
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDGU5MVktDQ04ZTB1NTUJDS1YeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktJSE5DQ1VKS0tVS1
	kG
DKIM-Signature: a=rsa-sha256;
	b=N+33e20hZPujV9M4SD7xaqas3npKFRMKKSSOOir1i5JvxRvctx8KW3XzrUeVG+4zlGZGjyuKumJtt0E1T5zwvyOLRMitdG5a7puLGouLfO2kzleozibEq64/YaHZ9CLKJH3xVwvUY6PWQiJYD0v9i2vk3DeJ2cydFl1lRnoSYZs=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=1aP+p3pkuZEJ5WqF20qIXkmTR7lKKQv4XO2CS/5zgQk=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31292-lists,linux-wireless=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zilin@seu.edu.cn,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:email]
X-Rspamd-Queue-Id: 4071AAC2AF
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 08:30:22AM -0800, Jeff Johnson wrote:
> On 1/19/2026 10:37 PM, Zilin Guan wrote:
> > The functions ath11k_mac_setup_bcn_tmpl_ema() and
> > ath11k_mac_setup_bcn_tmpl_mbssid() allocate memory for beacon templates
> > but fail to free it when parameter setup returns an error.
> > 
> > Since beacon templates must be released during normal execution, they
> > must also be released in the error handling paths to prevent memory
> > leaks.
> > 
> > Fix this by adding the missing deallocation calls in the respective
> > error paths.
> > 
> > Compile tested only. Issue found using a prototype static analysis tool
> > and code review.
> > 
> > Fixes: 3a415daa3e8b ("wifi: ath11k: add P2P IE in beacon template")
> > Fixes: 335a92765d30 ("wifi: ath11k: MBSSID beacon support")
> > Suggested-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
> > Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
> > ---
> > Changes in v2:
> > - Use unified exit paths for cleanup.
> > 
> >  drivers/net/wireless/ath/ath11k/mac.c | 25 +++++++++++++++----------
> >  1 file changed, 15 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
> > index 4dfd08b58416..42edcc5e9e49 100644
> > --- a/drivers/net/wireless/ath/ath11k/mac.c
> > +++ b/drivers/net/wireless/ath/ath11k/mac.c
> > @@ -1561,8 +1561,10 @@ static int ath11k_mac_setup_bcn_tmpl_ema(struct ath11k_vif *arvif,
> 
> while looking to apply this patch I noticed the following logic earlier in the
> function:
> 
>  	beacons = ieee80211_beacon_get_template_ema_list(tx_arvif->ar->hw,
>  							 tx_arvif->vif, 0);
>  	if (!beacons || !beacons->cnt) {
>  		ath11k_warn(arvif->ar->ab,
>  			    "failed to get ema beacon templates from mac80211\n");
>  		return -EPERM;
>  	}
> 
> I did not look at ieee80211_beacon_get_template_ema_list()
> But if it is possible that this can return a valid beacons pointer with
> beacons->cnt == 0, then won't this also leak the beacons allocation?
> 
> Given that ieee80211_beacon_free_ema_list(beacons) can handle a NULL
> beacons pointer, perhaps this should also goto free?

Hi Jeff,

Thanks for pointing that out.

I looked into the allocation chain for 
ieee80211_beacon_get_template_ema_list():

ieee80211_beacon_get_template_ema_list()
	|__ __ieee80211_beacon_get()
		|__ ieee80211_beacon_get_ap_ema_list()

It seems that ieee80211_beacon_get_ap_ema_list() only returns a valid 
pointer when ema->cnt is non-zero. Therefore, a valid beacons pointer with 
beacons->cnt == 0 is likely unreachable under the current mac80211 
implementation, making the existing check more of a defensive programming
measure.

However, for the sake of strict logical consistency, it would make sense 
to use the goto path there as well.

Do you think it's worth updating this in a v3, or is the current v2 
sufficient given the current call logic?

Best regards, 
Zilin

