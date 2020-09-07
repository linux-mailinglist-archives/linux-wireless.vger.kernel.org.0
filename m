Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA1AE25F6D5
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Sep 2020 11:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbgIGJtF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Sep 2020 05:49:05 -0400
Received: from a27-55.smtp-out.us-west-2.amazonses.com ([54.240.27.55]:57558
        "EHLO a27-55.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728243AbgIGJtE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Sep 2020 05:49:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599472143;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type;
        bh=h/F9s3TdWmFz2049ZhdD6P3+EixnBqB1Rp0L1wZZZXQ=;
        b=M+5seYk0WNqoUnkS8Ug9onJyxKnldU1wb0Izqjzwf13QIqV082/1r7iBd0ruPo6N
        mowPEUfyZWmOm6vAizOL7Um4YMPFqgQrKqpa0rqDpdtbZQxNmP35bprrhepLiJbPHMe
        vj8jRAL0P8o4CSi3cGJMFl39f/bBsR7C/+yqhvwQ=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599472143;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type:Feedback-ID;
        bh=h/F9s3TdWmFz2049ZhdD6P3+EixnBqB1Rp0L1wZZZXQ=;
        b=ksq56BnV5mOtYAneEOmRxvCGxR1SJGopPQOkYZM+Kwzo27yuT1kP0E/C8RiNyZwV
        5/rxM/bHMYZhxMHmAdy9KUfOnWbR1xlLwwGt75uoExj7V37YqxAnXLZRM6zbl0+Lm2O
        aA3jq/PG2Ijtyx5Wi5e8KXio0aBbeJaYjRBOqD5g=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1892AC4346F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc:     Wright Feng <wright.feng@cypress.com>,
        linux-wireless@vger.kernel.org, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        chi-hsien.lin@cypress.com
Subject: Re: [PATCH 1/4] brcmfmac: add change_bss to support AP isolation
References: <20200901063237.15549-1-wright.feng@cypress.com>
        <20200901063237.15549-2-wright.feng@cypress.com>
        <0101017467cf4336-e8ed5107-762a-431d-9ef0-a2631dd090be-000000@us-west-2.amazonses.com>
        <c90157f5-2c1a-1535-3453-450590857f74@broadcom.com>
Date:   Mon, 7 Sep 2020 09:49:03 +0000
In-Reply-To: <c90157f5-2c1a-1535-3453-450590857f74@broadcom.com> (Arend Van
        Spriel's message of "Mon, 7 Sep 2020 11:21:20 +0200")
Message-ID: <0101017467f80c0c-9d33c4e2-53c3-486a-8dec-40e51161feb4-000000@us-west-2.amazonses.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SES-Outgoing: 2020.09.07-54.240.27.55
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Arend Van Spriel <arend.vanspriel@broadcom.com> writes:

> On 9/7/2020 11:04 AM, Kalle Valo wrote:
>> Wright Feng <wright.feng@cypress.com> writes:
>>
>>> Hostap has a parameter "ap_isolate" which is used to prevent low-level
>>> bridging of frames between associated stations in the BSS.
>>> Regarding driver side, we add cfg80211 ops method change_bss to support
>>> setting AP isolation if firmware has ap_isolate feature.
>>>
>>> Signed-off-by: Wright Feng <wright.feng@cypress.com>
>>> Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
>>> ---
>>>   .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 23 +++++++++++++++++++
>>>   .../broadcom/brcm80211/brcmfmac/feature.c     |  1 +
>>>   .../broadcom/brcm80211/brcmfmac/feature.h     |  3 ++-
>>>   3 files changed, 26 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
>>> index 5d99771c3f64..7ef93cd66b2c 100644
>>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
>>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
>>> @@ -5425,6 +5425,26 @@ static int brcmf_cfg80211_del_pmk(struct wiphy *wiphy, struct net_device *dev,
>>>   	return brcmf_set_pmk(ifp, NULL, 0);
>>>   }
>>>   +static int
>>> +brcmf_cfg80211_change_bss(struct wiphy *wiphy, struct net_device *dev,
>>> +			  struct bss_parameters *params)
>>> +{
>>> +	struct brcmf_if *ifp;
>>> +	int ret = 0;
>>> +	u32 ap_isolate;
>>> +
>>> +	brcmf_dbg(TRACE, "Enter\n");
>>> +	ifp = netdev_priv(dev);
>>> +	if (params->ap_isolate >= 0) {
>>> +		ap_isolate = (u32)params->ap_isolate;
>>> +		ret = brcmf_fil_iovar_int_set(ifp, "ap_isolate", ap_isolate);
>>
>> Is the cast to u32 really necessary? Please avoid casts as much as
>> possible.
>
> It seems to me. struct bss_parameters::ap_isolate is typed as int. It
> is passed to brcmf_fil_iovar_int_set() which requires a u32 (maybe
> function name is causing the confusion).

What extra value does this explicit type casting bring here? I don't see
it. Implicit type casting would work the same, no?

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
