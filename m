Return-Path: <linux-wireless+bounces-23721-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 351E2ACE38A
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 19:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAF971762C8
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Jun 2025 17:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2ADC20B7FB;
	Wed,  4 Jun 2025 17:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Bsmgk8Vw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B771F2BAB
	for <linux-wireless@vger.kernel.org>; Wed,  4 Jun 2025 17:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749057784; cv=none; b=fIk7J/wbduh5l6LSOSJUCM/Up7svQU4djcz0L/09qYjVLNKQjk7gtGZ3F98t52uGxU2G2xsetVC+W7cQ13PVabnPK7vIcRDNiDpbi1APmVm30uwvFVsJbpllnsAiV3e7ALIT/Vd8tH57JAdBmM4amp8TIWRXb1I4XYel89a7gRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749057784; c=relaxed/simple;
	bh=OmTEHstArkAHrjsDUoN9e1e4lRuC+ejCHId8M5zjEzc=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=N+NPG2+4FmMohe2ZGTrEjdP2CyYYUlv3M4T0sKICe0MS4TFaIKldUUB4Z+eZ1Gaxkm8p6aKvR9zH9K807Wp5l2ZMerBAqolvlao06B7SpgzhfbgUm8iKKDeC9nqBAxhwJcrWFGitP2y48t42heQpqtMD5twVl1eMl1fXiKBUBxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Bsmgk8Vw; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-742c46611b6so198460b3a.1
        for <linux-wireless@vger.kernel.org>; Wed, 04 Jun 2025 10:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1749057782; x=1749662582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CIhNlf27pww/cPr3cpsXoQ6JcAm5nAqSVlxpqQ5GiMc=;
        b=Bsmgk8VwBV8rRuiR4mlwHfjxsjWxKVP5hvZyN1euUXxqFtTyqj0OEziWPJFu1/LZPa
         QUoCsUvneXTbmOuVGV7a8T9K4h0Vl34r9doOYN3+FFGjauqswyiSJwrkkES/2UYkZ9ZR
         2JErq+ZfYffdwBs+6CSweg+LMcm606r5YiagY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749057782; x=1749662582;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CIhNlf27pww/cPr3cpsXoQ6JcAm5nAqSVlxpqQ5GiMc=;
        b=LthotbVJG7xUQMLsQ14l06mXgsOXKK24ohpRWBPJcgcrwS9o3NrUQOVeK+2rxmz/Oe
         ZUkgGgQG8bpuhsEfEnnPHHJu1BGlbNiL1IDdCra+EmD6kbHkRtK0Rf1nNi6jmBol/UEM
         zDUseBnc2QfSZduNKFDAUks/8dyv5nYDyoQCZ1x8H5dVeAignaS/D6ZL3JRlZ815RtRw
         zo+u/+3X77ZAks/ajvM7IoDFLMZT2xWmdh/a4FFvEJ3f2XTNueyfAl/i41zYpn+UrgCd
         1GR5bS6HFzPE3XDZhPA9GLRP/E5kM1y58SufLL5AwK1DErX5vkbaKs2gsCJon6VNXIm3
         eEQQ==
X-Gm-Message-State: AOJu0Ywwc2NgmZ/VIq2u64HkZV/ZBcxqbIhSqwHOECM03+OB2jWFr7DM
	r+EsXz+FdCkuVuPh20LjWF7y8o4/EW0CTQBnj7cVpEUeBdWhe0R6a5IOMe3JoLcwIQ==
X-Gm-Gg: ASbGncs7mXcel56uhEvHF7xB9G9iGqQZ7WhGDyMk4d2MNJnfMAV+asAxXo62tIgrrd+
	btXcifu6M4XgyfuIPpnSigxW35TgwsfM6vyxKPnODGjhDDznuwayg/gSDfjOm9Y4i3tOjYSCwXd
	pSLlvQOJcICVNad+sp+59HPvYjCWoxT/+JUdgMHimS7AGC7/Om57WNZu7rXuX8DZ0wPRn9VYwqc
	bCV4nolFwCCpfUnMykDMC7jAoN0OGRmgEz+IZWgamDwCSXKL4XqoKw5jklyMosC0XZEq0LgRw0a
	vPX/8pJJ6rCuE/xwJxEGo+IojnHUgHgWEBH+K0djUNuDNlR3kNyIdlDt7RfLO6P1Q+SUzM5cEQo
	QZW1JK9NHzMtG
X-Google-Smtp-Source: AGHT+IGv5B8APUjeV7/ZcGZxpWjVS3IDO2LNxHbOrVP+re8pGjuCsnjgZXfjt92dItfKvouNVh+hEQ==
X-Received: by 2002:a05:6a00:1253:b0:740:a879:4f7b with SMTP id d2e1a72fcca58-7480b452fccmr5386852b3a.18.1749057782362;
        Wed, 04 Jun 2025 10:23:02 -0700 (PDT)
Received: from [10.229.40.11] ([192.19.176.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2ecebb3efesm8942388a12.68.2025.06.04.10.22.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jun 2025 10:23:01 -0700 (PDT)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <brcm80211@lists.linux.dev>, Wright Feng <wright.feng@cypress.com>, "Chi-hsien Lin" <chi-hsien.lin@cypress.com>, Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
Date: Wed, 04 Jun 2025 19:22:58 +0200
Message-ID: <1973bf7b150.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <c541e288-7859-4f50-a4a8-b7a6ee38cd99@oss.qualcomm.com>
References: <20250604085539.2803896-1-arend.vanspriel@broadcom.com>
 <20250604085539.2803896-5-arend.vanspriel@broadcom.com>
 <c541e288-7859-4f50-a4a8-b7a6ee38cd99@oss.qualcomm.com>
User-Agent: AquaMail/1.55.1 (build: 105501552)
Subject: Re: [RFC 4/4] brcmfmac: support AP isolation to restrict reachability between stations
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On June 4, 2025 4:37:02 PM Jeff Johnson <jeff.johnson@oss.qualcomm.com> wrote:

> On 6/4/2025 1:55 AM, Arend van Spriel wrote:
>> From: Wright Feng <wright.feng@cypress.com>
>>
>> hostapd & wpa_supplicant userspace daemons exposes an AP mode specific
>> config file parameter "ap_isolate" to the user, which is used to control
>> low-level bridging of frames between the stations associated in the BSS.
>>
>> In driver, handle this user setting in the newly defined cfg80211_ops
>> function brcmf_cfg80211_change_bss() by enabling "ap_isolate" IOVAR in
>> the firmware.
>>
>> In AP mode, the "ap_isolate" value from the cfg80211 layer represents,
>> 0 = allow low-level bridging of frames between associated stations
>> 1 = restrict low-level bridging of frames to isolate associated stations
>> -1 = do not change existing setting
>>
>> Signed-off-by: Wright Feng <wright.feng@cypress.com>
>> Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
>> Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
>> [arend: indicate ap_isolate support in struct wiphy::bss_param_support]
>> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
>> ---
>> .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 24 +++++++++++++++++++
>> 1 file changed, 24 insertions(+)
>>
>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c 
>> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
>> index dc2383faddd1..d6c8ad7ebced 100644
>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
>> @@ -5933,6 +5933,26 @@ static int brcmf_cfg80211_del_pmk(struct wiphy 
>> *wiphy, struct net_device *dev,
>> return brcmf_set_pmk(ifp, NULL, 0);
>> }
>>
>> +static int brcmf_cfg80211_change_bss(struct wiphy *wiphy, struct 
>> net_device *dev,
>> +     struct bss_parameters *params)
>> +{
>> + struct brcmf_if *ifp = netdev_priv(dev);
>> + int ret = 0;
>> +
>> + /* In AP mode, the "ap_isolate" value represents
>> + *  0 = allow low-level bridging of frames between associated stations
>> + *  1 = restrict low-level bridging of frames to isolate associated stations
>> + * -1 = do not change existing setting
>> + */
>> + if (params->ap_isolate >= 0) {
>> + ret = brcmf_fil_iovar_int_set(ifp, "ap_isolate", params->ap_isolate);
>> + if (ret < 0)
>> + brcmf_err("ap_isolate iovar failed: ret=%d\n", ret);
>> + }
>> +
>> + return ret;
>> +}
>> +
>> static struct cfg80211_ops brcmf_cfg80211_ops = {
>> .add_virtual_intf = brcmf_cfg80211_add_iface,
>> .del_virtual_intf = brcmf_cfg80211_del_iface,
>> @@ -5980,6 +6000,7 @@ static struct cfg80211_ops brcmf_cfg80211_ops = {
>> .update_connect_params = brcmf_cfg80211_update_conn_params,
>> .set_pmk = brcmf_cfg80211_set_pmk,
>> .del_pmk = brcmf_cfg80211_del_pmk,
>> + .change_bss = brcmf_cfg80211_change_bss,
>> };
>
> So the real question is do we really *need* all of the other patches, or is it
> OK for the driver to just process the one attribute it wants without
> indicating that is the only attribute it handles to userspace? I know of one
> out-of-tree cfg80211 driver that has only handled AP isolate for a long time,
> and AFAIK there have not been any issues.
>
> In other words, why isn't just the two diffs above enough to satisfy the need?
>
>>
>> struct cfg80211_ops *brcmf_cfg80211_get_ops(struct brcmf_mp_device *settings)
>> @@ -7634,6 +7655,9 @@ static int brcmf_setup_wiphy(struct wiphy *wiphy, 
>> struct brcmf_if *ifp)
>> BIT(NL80211_BSS_SELECT_ATTR_BAND_PREF) |
>> BIT(NL80211_BSS_SELECT_ATTR_RSSI_ADJUST);
>>
>> +
>> + wiphy->bss_param_support = WIPHY_BSS_PARAM_AP_ISOLATE;
>> +
>> wiphy->flags |= WIPHY_FLAG_NETNS_OK |
>> WIPHY_FLAG_PS_ON_BY_DEFAULT |
>> WIPHY_FLAG_HAVE_AP_SME |
>
> Ultimately that out-of-tree driver I know so well would adopt this scheme if
> it lands, but it currently support AP isolate without all of the other changes.

The first patch that initiated this was a brcmfmac patch which probably 
followed the same approach as the oot driver you know so well. Here is the 
patchwork link with the discussion that followed:

https://patchwork.kernel.org/project/linux-wireless/patch/20250423175125.7233-1-gokulkumar.sivakumar@infineon.com/

Regards,
Arend




