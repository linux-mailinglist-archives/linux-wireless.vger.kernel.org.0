Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C95DF65C7AA
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Jan 2023 20:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237127AbjACTow (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Jan 2023 14:44:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbjACTov (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Jan 2023 14:44:51 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6319313F7D
        for <linux-wireless@vger.kernel.org>; Tue,  3 Jan 2023 11:44:50 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id qb7so7353178qvb.5
        for <linux-wireless@vger.kernel.org>; Tue, 03 Jan 2023 11:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ofoPcYutyv+xy9ELBhp1Pn1o2uvJnNCS2tt94OFmJUU=;
        b=ZVIMSZGQgZBj2wNHbv6VQrmTkPZRlNgfe8B4De1A1UatVFPVOCB6dawRWXFRinYSIO
         H3iPzTbznsVU3DBisbNymDxv1hZkGCUXFnC19p7xPyqbhAR0Bu5psKAQjc9fN3GQTH0A
         CbiuakUb4hbeSGTG8FwcnE9eDRLsjp/+4x7i8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ofoPcYutyv+xy9ELBhp1Pn1o2uvJnNCS2tt94OFmJUU=;
        b=z/8u1er8ExTXN/U7e7SIzZm5xDJTuHXvYq2sXs4+7pG2OU9AaklMNGlRf4w4P48JJ6
         aRNiKamd9pvh2XEIe5snZa4kR4C3VNd+ba+b7fXGj/CFv96qCTfHxbrz/f2DgIYf+Ihs
         koeNkkgijdcqi2uFfX1UFOZmJFE4NQrrtjpqxBpcQwnUNFrHT2gA8ilw38gnj1jfS8mH
         cftndDHRR21fuNNLp290/ekCB0vXCPuIE/l4nDggkxjl76FaABlLkJBwWqBSB1VDzh3t
         XE1qgOarJ4QaBg3bXxjAK9r5aVjkL/K4fvVD8ZU/27Xedt4aZr0sMqQP+bEE8qGpxkKD
         gNyg==
X-Gm-Message-State: AFqh2kqz52DdGwNoCNyA6Pwmdz8yMS71ptltMCjxCNGafmIBKHxF0NSc
        reFsYvxxoohNBzNch2nWGKEOhT/wPRkptrKTVW4=
X-Google-Smtp-Source: AMrXdXvCWzN6G3T0x6JjmH0ASaJjbJUlSYljXcXHxl52+sOWSEd6yV/x8/zvqZKjcUwKad7xPAselQ==
X-Received: by 2002:a0c:bf52:0:b0:531:dcf9:a17e with SMTP id b18-20020a0cbf52000000b00531dcf9a17emr2807490qvj.26.1672775089157;
        Tue, 03 Jan 2023 11:44:49 -0800 (PST)
Received: from [192.168.178.136] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id u5-20020a05620a0c4500b006cfc1d827cbsm22577481qki.9.2023.01.03.11.44.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 11:44:48 -0800 (PST)
Message-ID: <049104ef-8e32-00b5-649a-1564564a8099@broadcom.com>
Date:   Tue, 3 Jan 2023 20:44:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH for-6.2 1/3] wifi: brcmfmac: avoid handling disabled
 channels for survey dump
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org
References: <20230103124117.271988-1-arend.vanspriel@broadcom.com>
 <20230103124117.271988-2-arend.vanspriel@broadcom.com>
 <0cd97839-b293-9c0b-be88-9bfe9fe510f4@i2se.com>
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
In-Reply-To: <0cd97839-b293-9c0b-be88-9bfe9fe510f4@i2se.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000002b7805f1614d55"
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--000000000000002b7805f1614d55
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/3/2023 8:15 PM, Stefan Wahren wrote:
> Hi Arend,
> hi Kalle,
> 
> Am 03.01.23 um 13:41 schrieb Arend van Spriel:
>> An issue was reported in which periodically error messages are
>> printed in the kernel log:
>>
>> [   26.303445] brcmfmac: brcmf_fw_alloc_request: using 
>> brcm/brcmfmac43455-sdio for chip BCM4345/6
>> [   26.303554] brcmfmac mmc1:0001:1: Direct firmware load for 
>> brcm/brcmfmac43455-sdio.raspberrypi,3-model-b-plus.bin failed with 
>> error -2
>> [   26.516752] brcmfmac_wcc: brcmf_wcc_attach: executing
> regardless of this patch the commit d6a5c562214f ("wifi: brcmfmac: add 
> support for vendor-specific firmware api") introduced this error message 
> wcc/core.c, but i guess this should be trace or info message?

Ah, yes. I will change that for the next release. Thanks for pointing at 
that.

>> [   26.528264] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4345/6 
>> wl0: Jan  4 2021 19:56:29 version 7.45.229 (617f1f5 CY) FWID 01-2dbd9d2e
>> [   27.076829] Bluetooth: hci0: BCM: features 0x2f
>> [   27.078592] Bluetooth: hci0: BCM43455 37.4MHz Raspberry Pi 3+
>> [   27.078601] Bluetooth: hci0: BCM4345C0 (003.001.025) build 0342

[...]

>> Fixes: 6c04deae1438 ("brcmfmac: Add dump_survey cfg80211 ops for 
>> HostApd AutoChannelSelection")
>> Reported-by: Stefan Wahren <stefan.wahren@i2se.com>
>> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> 
> this patch is:
> 
> Tested-by: Stefan Wahren <stefan.wahren@i2se.com>

Appreciated.

Regards,
Arend

> Thanks
>> ---
>>   .../broadcom/brcm80211/brcmfmac/cfg80211.c       | 16 +++++++---------
>>   1 file changed, 7 insertions(+), 9 deletions(-)
>>
>> diff --git 
>> a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c 
>> b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
>> index bff3128c2f26..478ca3848c64 100644
>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
>> @@ -7937,6 +7937,9 @@ cfg80211_set_channel(struct wiphy *wiphy, struct 
>> net_device *dev,
>>       struct brcmf_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
>>       struct brcmf_if *ifp = netdev_priv(cfg_to_ndev(cfg));
>> +    if (chan->flags & IEEE80211_CHAN_DISABLED)
>> +        return -EINVAL;
>> +
>>       /* set_channel */
>>       chspec = channel_to_chanspec(&cfg->d11inf, chan);
>>       if (chspec != INVCHANSPEC) {
>> @@ -7961,7 +7964,6 @@ brcmf_cfg80211_dump_survey(struct wiphy *wiphy, 
>> struct net_device *ndev,
>>       struct brcmf_if *ifp = netdev_priv(cfg_to_ndev(cfg));
>>       struct brcmf_dump_survey survey = {};
>>       struct ieee80211_supported_band *band;
>> -    struct ieee80211_channel *chan;
>>       struct cca_msrmnt_query req;
>>       u32 noise;
>>       int err;
>> @@ -7987,13 +7989,10 @@ brcmf_cfg80211_dump_survey(struct wiphy 
>> *wiphy, struct net_device *ndev,
>>       }
>>       /* Setting current channel to the requested channel */
>> -    chan = &band->channels[idx];
>> -    err = cfg80211_set_channel(wiphy, ndev, chan, NL80211_CHAN_HT20);
>> -    if (err) {
>> -        info->channel = chan;
>> -        info->filled = 0;
>> +    info->filled = 0;
>> +    info->channel = &band->channels[idx];
>> +    if (cfg80211_set_channel(wiphy, ndev, info->channel, 
>> NL80211_CHAN_HT20))
>>           return 0;
>> -    }
>>       /* Disable mpc */
>>       brcmf_set_mpc(ifp, 0);
>> @@ -8028,7 +8027,6 @@ brcmf_cfg80211_dump_survey(struct wiphy *wiphy, 
>> struct net_device *ndev,
>>       if (err)
>>           goto exit;
>> -    info->channel = chan;
>>       info->noise = noise;
>>       info->time = ACS_MSRMNT_DELAY;
>>       info->time_busy = ACS_MSRMNT_DELAY - survey.idle;
>> @@ -8040,7 +8038,7 @@ brcmf_cfg80211_dump_survey(struct wiphy *wiphy, 
>> struct net_device *ndev,
>>           SURVEY_INFO_TIME_TX;
>>       brcmf_dbg(INFO, "OBSS dump: channel %d: survey duration %d\n",
>> -          ieee80211_frequency_to_channel(chan->center_freq),
>> +          ieee80211_frequency_to_channel(info->channel->center_freq),
>>             ACS_MSRMNT_DELAY);
>>       brcmf_dbg(INFO, "noise(%d) busy(%llu) rx(%llu) tx(%llu)\n",
>>             info->noise, info->time_busy, info->time_rx, info->time_tx);

--000000000000002b7805f1614d55
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
2Gzj3QNJRLsZu1TLyOyBBIr/BE7UiY3RabgRzknBGAPmzhS+fmyM8OtM5BYBsFBrSUFtZZO2p/tf
Nbc24J2zf2peoZ8MK+7WQqummYlOnz+FyDkA9EybeNMcS5C+xi/PAgMBAAGjggHdMIIB2TAOBgNV
HQ8BAf8EBAMCBaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRwOi8vc2VjdXJl
Lmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcnQwQQYI
KwYBBQUHMAGGNWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24y
Y2EyMDIwME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3
dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRCMEAwPqA8oDqG
OGh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3Js
MCcGA1UdEQQgMB6BHGFyZW5kLnZhbnNwcmllbEBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYB
BQUHAwQwHwYDVR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0OBBYEFIikAXd8CEtv
ZbDflDRnf3tuStPuMA0GCSqGSIb3DQEBCwUAA4IBAQCdS5XCYx6k2GGZui9DlFsFm75khkqAU7rT
zBX04sJU1+B1wtgmWTVIzW7ugdtDZ4gzaV0S9xRhpDErjJaltxPbCylb1DEsLj+AIvBR34caW6ZG
sQk444t0HPb29HnWYj+OllIGMbdJWr0/P95ZrKk2bP24ub3ZP/8SyzrohfIba9WZKMq6g2nTLZE3
BtkeSGJx/8dy0h8YmRn+adOrxKXHxhSL8BNn8wsmIZyYWe6fRcBtO3Ks2DOLyHCdkoFlN8x9VUQF
N2ulEgqCbRKkx+qNirW86eF138lr1gRxzclu/38ko//MmkAYR/+hP3WnBll7zbpIt0jc9wyFkSqH
p8a1MYICbTCCAmkCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1z
YTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIMTv1t
bpIzNUky46LXMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDRpLnwxFuQyYkvyLti
FlLRqGWEJEL2Hlmrtc44cvbtMDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yMzAxMDMxOTQ0NDlaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAgYWyQzVJoPmQbDoKnuEjT5NHlVayb45uzY7D
CMli4ZTbSOSCUhPARrb59tS8BCUJsUJ68R/bTs+vUTdYLithUeEtxrxlqm6ymzPH1zq8AosxdOK+
rTaLz8XHRn4HjGgdT2hijLT29mL0JP901CxE7azN47TnGM6UM4lKBHp0cI0tleyijx2g0DqPNR5q
dclAeDQK+fgkjfQ7h3mBJHkLUEn3KBzJ/tq1vtzRzh0sSFIrprNw34fDdMJGqwU0kUDpC8+2K8/+
QKgmKLbEtErTwUGTOfUUvmEJRSLhthfx1/6hLlF+mBN0K+ahOnReo7mFYylW41RPzSelMUT1YPqa
Qw==
--000000000000002b7805f1614d55--
