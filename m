Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E91F5199B9
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2019 10:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbfEJIct convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 May 2019 04:32:49 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:40792 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727010AbfEJIct (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 May 2019 04:32:49 -0400
Received: from [172.20.10.2] (x590fee18.dyn.telefonica.de [89.15.238.24])
        by mail.holtmann.org (Postfix) with ESMTPSA id A1DD0CF170;
        Fri, 10 May 2019 10:41:01 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [PATCH 5/6] cfg80211: add support for SAE authentication offload
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190509092103.GD74912@aremote06.aus.cypress.com>
Date:   Fri, 10 May 2019 10:32:44 +0200
Cc:     Chi-Hsien Lin <Chi-Hsien.Lin@cypress.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "brcm80211-dev-list@broadcom.com" <brcm80211-dev-list@broadcom.com>,
        brcm80211-dev-list <brcm80211-dev-list@cypress.com>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Wright Feng <Wright.Feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <5B8ACEB5-FDD4-46D0-AC9C-2DF04EE4AC4F@holtmann.org>
References: <1546582221-143220-1-git-send-email-chi-hsien.lin@cypress.com>
 <1546582221-143220-5-git-send-email-chi-hsien.lin@cypress.com>
 <2FC4C72C-9E57-4195-A682-F7BAE7F3981E@holtmann.org>
 <20190509092103.GD74912@aremote06.aus.cypress.com>
To:     Stanley Hsu <Stanley.Hsu@cypress.com>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Stanley,

>>> Let drivers advertise support for station-mode SAE authentication
>>> offload with a new NL80211_EXT_FEATURE_SAE_OFFLOAD flag.
>>> 
>>> Signed-off-by: Chung-Hsien Hsu <stanley.hsu@cypress.com>
>>> Signed-off-by: Chi-Hsien Lin <chi-hsien.lin@cypress.com>
>>> ---
>>> include/linux/ieee80211.h    |  1 +
>>> include/net/cfg80211.h       |  5 +++++
>>> include/uapi/linux/nl80211.h | 16 ++++++++++++++++
>>> net/wireless/nl80211.c       | 14 ++++++++++++++
>>> 4 files changed, 36 insertions(+)
>>> 
>>> diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
>>> index 3b04e72315e1..37d3e655e547 100644
>>> --- a/include/linux/ieee80211.h
>>> +++ b/include/linux/ieee80211.h
>>> @@ -2596,6 +2596,7 @@ enum ieee80211_key_len {
>>> #define FILS_ERP_MAX_RRK_LEN64
>>> 
>>> #define PMK_MAX_LEN64
>>> +#define SAE_PASSWORD_MAX_LEN128
>>> 
>>> /* Public action codes (IEEE Std 802.11-2016, 9.6.8.1, Table 9-307) */
>>> enum ieee80211_pub_actioncode {
>>> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
>>> index e0c41eb1c860..5809dac97b33 100644
>>> --- a/include/net/cfg80211.h
>>> +++ b/include/net/cfg80211.h
>>> @@ -740,6 +740,9 @@ struct survey_info {
>>> *CFG80211_MAX_WEP_KEYS WEP keys
>>> * @wep_tx_key: key index (0..3) of the default TX static WEP key
>>> * @psk: PSK (for devices supporting 4-way-handshake offload)
>>> + * @sae_pwd: password for SAE authentication (for devices supporting SAE
>>> + *offload)
>>> + * @sae_pwd_len: length of SAE password (for devices supporting SAE offload)
>>> */
>>> struct cfg80211_crypto_settings {
>>> u32 wpa_versions;
>>> @@ -755,6 +758,8 @@ struct cfg80211_crypto_settings {
>>> struct key_params *wep_keys;
>>> int wep_tx_key;
>>> const u8 *psk;
>>> +const u8 *sae_pwd;
>>> +u16 sae_pwd_len;
>>> };
>>> 
>>> /**
>>> diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
>>> index 12762afb3a07..4840aaed39ba 100644
>>> --- a/include/uapi/linux/nl80211.h
>>> +++ b/include/uapi/linux/nl80211.h
>>> @@ -235,6 +235,15 @@
>>> */
>>> 
>>> /**
>>> + * DOC: SAE authentication offload
>>> + *
>>> + * By setting @NL80211_EXT_FEATURE_SAE_OFFLOAD flag drivers can indicate they
>>> + * support offloading SAE authentication for WPA3-Personal networks. In
>>> + * %NL80211_CMD_CONNECT the password for SAE should be specified using
>>> + * %NL80211_ATTR_SAE_PASSWORD.
>>> + */
>>> +
>>> +/**
>>> * enum nl80211_commands - supported nl80211 commands
>>> *
>>> * @NL80211_CMD_UNSPEC: unspecified command to catch errors
>>> @@ -2288,6 +2297,9 @@ enum nl80211_commands {
>>> *
>>> * @NL80211_ATTR_FTM_RESPONDER_STATS: Nested attribute with FTM responder
>>> *statistics, see &enum nl80211_ftm_responder_stats.
>>> + * @NL80211_ATTR_SAE_PASSWORD: attribute for passing SAE password material. It
>>> + *is used with %NL80211_CMD_CONNECT to provide password for offloading
>>> + *SAE authentication for WPA3-Personal networks.
>>> *
>>> * @NL80211_ATTR_TIMEOUT: Timeout for the given operation in milliseconds (u32),
>>> *if the attribute is not given no timeout is requested. Note that 0 is an
>>> @@ -2743,6 +2755,7 @@ enum nl80211_attrs {
>>> NL80211_ATTR_FTM_RESPONDER,
>>> 
>>> NL80211_ATTR_FTM_RESPONDER_STATS,
>>> +NL80211_ATTR_SAE_PASSWORD,
>>> 
>>> NL80211_ATTR_TIMEOUT,
>> 
>> so you are breaking user-space API on purpose here even when there was a clear comment where to add new attributes:
>> 
>> /* add attributes here, update the policy in nl80211.c */
> 
> Hi Marcel,
> 
> Thanks for pointing this out. It was a mistake caused by rebasing the
> patch. Will fix it in V2.
> 
>> 
>> More importantly, does this actually need a new attribute and you can not utilize what has already been added for mesh? If this attribute is solely for offload cases, then it might be better named accordingly. Also I am curious on how mixed WPA1/WPA2/WPA3 network credentials are now provided to a CMD_CONNECT. So the CMD_CONNECT description might require an update as well.
> 
> This new attribute is used to pass the sae_password value, set in the
> configuration file of wpa_supplicant, for offloading SAE authentication.
> It seems that the existing attributes can not be utilized for the
> purpose. Could you please point it out if you know the proper one? To
> reflect the content of the attribute, NL80211_ATTR_SAE_PASSWORD should
> be a proper name.

not everything is wpa_supplicant config files. How does this work with iwd for example. The user can not set a specific SAW password since that is all handled internally.

> As for the mixed WPA/WPA2/WPA3 network credentials, no key materials
> will be provided in a NL80211_CMD_CONNECT for non-offload cases. When
> offload is considered, there is no conflict between WPA/WPA2 4-way
> handshake offload and SAE authentication offload. For the WPA/WPA2
> 4-way handshake offload, the PSK is specified using NL80211_ATTR_PMK in
> the NL80211_CMD_CONNECT. The corresponding description can be found in
> the section "DOC: WPA/WPA2 EAPOL handshake offload". As for the SAE
> authentication offload, the sae_password value is provided by
> NL80211_ATTR_SAE_PASSWORD in NL80211_CMD_CONNECT. It is described in
> the section "DOC: SAE authentication offload" proposed in this patch.

Do we have some documentation on how to handle offload for mixed WPA/WPA2/WPA3 networks? I really wonder how nl80211 is supposed to be used in these cases. As mentioned above, not everything is wpa_supplicant and I am curious on how seamless roaming will actually work for offload cases.

Regards

Marcel

