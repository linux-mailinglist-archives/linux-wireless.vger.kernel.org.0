Return-Path: <linux-wireless+bounces-25229-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3289DB00DA8
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 23:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 116271CA6130
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 21:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AA82FCE10;
	Thu, 10 Jul 2025 21:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="FG2eGnLe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF13B2F0E50
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 21:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752182328; cv=none; b=igxpOhauxvcm2MjB6+MHzwtiY/4mDfSv+JAyDWfVVSG0y6uHh2rm8QBdM6KNyHK4aDH7CgHouh14ov9wiAP1e0jK4rBGmDsHAz+Nmfhpw2e0Dl54uny4C/HYog5SXXS9BLpQRdw4lxQldNIdL8Y7zZBw/ABLEX1NwP1QcwFjGGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752182328; c=relaxed/simple;
	bh=36JLewMX/N1GHI4EbWwxvAdC26g9H0wHX+8VFaTqgMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YmPwAC+z+gBu5WbDwq55O8WjeDLi4S77VXGzv+CdsLqd/fghnKihCuhh9eTAcE4QuKWk/T7RAre6sahPLsQqlYjObqWGu/p+An1mlNvIPXxOKunzxysXR9IbfUFmD+Egc26FJYfp2w6sAviXF0cIwJKJ+3fbJzxXPpoYQ8Kutvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=FG2eGnLe; arc=none smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id DF48B1C006F;
	Thu, 10 Jul 2025 21:18:38 +0000 (UTC)
Received: from [172.31.1.211] (71-212-32-17.tukw.qwest.net [71.212.32.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 696A013C2B0;
	Thu, 10 Jul 2025 14:18:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 696A013C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1752182314;
	bh=36JLewMX/N1GHI4EbWwxvAdC26g9H0wHX+8VFaTqgMA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FG2eGnLecXR2Fg8mGhpeaUONlE1yJp6rfbG4YiytG5/Y3Qa2u/7/U1Qijpehv82n/
	 84ybzx9ml2pklyUEQej3EXoDMreKarQClKXbcSeS9ixP7n67YEBK6U6O2YSFsNsEzX
	 acia44ydb9mACnR5qnXWL3JSCDyjc4vDtIwFfCnk=
Message-ID: <206f759a-f781-4a34-ab0a-2854c9129297@candelatech.com>
Date: Thu, 10 Jul 2025 14:18:34 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next] wifi: mac80211_hwsim: Update comments in
 header
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
References: <20250710211437.8516-1-alex.gavin@candelatech.com>
Content-Language: en-US
From: Alex Gavin <alex.gavin@candelatech.com>
In-Reply-To: <20250710211437.8516-1-alex.gavin@candelatech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-MDID: 1752182319-T3B3mdgxZ4YC
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;ut7;1752182319;T3B3mdgxZ4YC;<alex.gavin@candelatech.com>;b42792dba290a1257c3f0aaf1c60b0ff
X-PPE-TRUSTED: V=1;DIR=OUT;

On 7/10/25 14:14, Alex Gavin wrote:
> - Reorders 'HWSIM_ATTR_PAD' to after 'HWSIM_ATTR_FREQ',
>   matching order in 'enum hwsim_attrs'
> - Change references from old commands to new names
> - Fixes typos
> 
> Signed-off-by: Alex Gavin <alex.gavin@candelatech.com>
> ---
>  drivers/net/wireless/virtual/mac80211_hwsim.h | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.h b/drivers/net/wireless/virtual/mac80211_hwsim.h
> index f32fc3a492b0..fa157c883f7f 100644
> --- a/drivers/net/wireless/virtual/mac80211_hwsim.h
> +++ b/drivers/net/wireless/virtual/mac80211_hwsim.h
> @@ -62,7 +62,7 @@ enum hwsim_tx_control_flags {
>   * @HWSIM_CMD_TX_INFO_FRAME: Transmission info report from user space to
>   *	kernel, uses:
>   *	%HWSIM_ATTR_ADDR_TRANSMITTER, %HWSIM_ATTR_FLAGS,
> - *	%HWSIM_ATTR_TX_INFO, %WSIM_ATTR_TX_INFO_FLAGS,
> + *	%HWSIM_ATTR_TX_INFO, %HWSIM_ATTR_TX_INFO_FLAGS,
>   *	%HWSIM_ATTR_SIGNAL, %HWSIM_ATTR_COOKIE
>   * @HWSIM_CMD_NEW_RADIO: create a new radio with the given parameters,
>   *	returns the radio ID (>= 0) or negative on errors, if successful
> @@ -126,24 +126,24 @@ enum hwsim_commands {
>   *	space
>   * @HWSIM_ATTR_TX_INFO: ieee80211_tx_rate array
>   * @HWSIM_ATTR_COOKIE: sk_buff cookie to identify the frame
> - * @HWSIM_ATTR_CHANNELS: u32 attribute used with the %HWSIM_CMD_CREATE_RADIO
> + * @HWSIM_ATTR_CHANNELS: u32 attribute used with the %HWSIM_CMD_NEW_RADIO
>   *	command giving the number of channels supported by the new radio
>   * @HWSIM_ATTR_RADIO_ID: u32 attribute used with %HWSIM_CMD_DESTROY_RADIO
>   *	only to destroy a radio
> - * @HWSIM_ATTR_REG_HINT_ALPHA2: alpha2 for regulatoro driver hint
> + * @HWSIM_ATTR_REG_HINT_ALPHA2: alpha2 for regulatory driver hint
>   *	(nla string, length 2)
>   * @HWSIM_ATTR_REG_CUSTOM_REG: custom regulatory domain index (u32 attribute)
>   * @HWSIM_ATTR_REG_STRICT_REG: request REGULATORY_STRICT_REG (flag attribute)
>   * @HWSIM_ATTR_SUPPORT_P2P_DEVICE: support P2P Device virtual interface (flag)
> - * @HWSIM_ATTR_USE_CHANCTX: used with the %HWSIM_CMD_CREATE_RADIO
> + * @HWSIM_ATTR_USE_CHANCTX: used with the %HWSIM_CMD_NEW_RADIO
>   *	command to force use of channel contexts even when only a
>   *	single channel is supported
> - * @HWSIM_ATTR_DESTROY_RADIO_ON_CLOSE: used with the %HWSIM_CMD_CREATE_RADIO
> + * @HWSIM_ATTR_DESTROY_RADIO_ON_CLOSE: used with the %HWSIM_CMD_NEW_RADIO
>   *	command to force radio removal when process that created the radio dies
>   * @HWSIM_ATTR_RADIO_NAME: Name of radio, e.g. phy666
>   * @HWSIM_ATTR_NO_VIF:  Do not create vif (wlanX) when creating radio.
> - * @HWSIM_ATTR_PAD: padding attribute for 64-bit values, ignore
>   * @HWSIM_ATTR_FREQ: Frequency at which packet is transmitted or received.
> + * @HWSIM_ATTR_PAD: padding attribute for 64-bit values, ignore
>   * @HWSIM_ATTR_TX_INFO_FLAGS: additional flags for corresponding
>   *	rates of %HWSIM_ATTR_TX_INFO
>   * @HWSIM_ATTR_PERM_ADDR: permanent mac address of new radio
> @@ -151,7 +151,7 @@ enum hwsim_commands {
>   * @HWSIM_ATTR_CIPHER_SUPPORT: u32 array of supported cipher types
>   * @HWSIM_ATTR_MLO_SUPPORT: claim MLO support (exact parameters TBD) for
>   *	the new radio
> - * @HWSIM_ATTR_PMSR_SUPPORT: nested attribute used with %HWSIM_CMD_CREATE_RADIO
> + * @HWSIM_ATTR_PMSR_SUPPORT: nested attribute used with %HWSIM_CMD_NEW_RADIO
>   *	to provide peer measurement capabilities. (nl80211_peer_measurement_attrs)
>   * @HWSIM_ATTR_PMSR_REQUEST: nested attribute used with %HWSIM_CMD_START_PMSR
>   *	to provide details about peer measurement request (nl80211_peer_measurement_attrs)

Noticed these in developing some automation. I also noticed that 'hwsim_new_radio_nl()' returns
the radio ID after creation. This results 'HWSIM_CMD_NEW_RADIO' command response setting the
error genl message error code to the new radio's ID.

Both hostap and iwd rely on this behavior for their hwsim test automation, so I imagine the
existing behavior is best left as is?


Best,

Alex


