Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7264A262908
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Sep 2020 09:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730022AbgIIHih (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Sep 2020 03:38:37 -0400
Received: from a27-11.smtp-out.us-west-2.amazonses.com ([54.240.27.11]:58752
        "EHLO a27-11.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726399AbgIIHib (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Sep 2020 03:38:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599637110;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:Cc:Message-Id:Date;
        bh=lqMW2WYEhSEmdQ0wtQbxHzL/cIsNdkFj5GXHGjQf5X4=;
        b=Pa8s2OeNqWX9xo1ekOyqj38DLNm4vC1piCPBK9GdBpK6PMkVLJnoMy+n8nLyvKnc
        fl2J2NukVmufQvTk+PHXI1K+VPy+XingrBOLy1sWz1/ZEUJH9odgzQm6gWA/HyHbXp/
        9L69tpf22dwxQgqdG3Mu5v3Ha0N+ONTffq/h7hqM=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599637110;
        h=Content-Type:MIME-Version:Content-Transfer-Encoding:Subject:From:In-Reply-To:References:To:Cc:Message-Id:Date:Feedback-ID;
        bh=lqMW2WYEhSEmdQ0wtQbxHzL/cIsNdkFj5GXHGjQf5X4=;
        b=SiIjh/iIPv5AMlRmbGG+IxU4eFcYOU3jB7Y8RZPuIlrMuujYDzSWayQwQhuKQGbI
        rkR/63Jz6CNSd4Hw8iiITMW1u/frFSA7O7azNpomSpFDSp3IvW4JGp4+uFZi78dxs0P
        wEZYY42HUV5InMe3c39k/IMEhdG84f7xf1i84f8g=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B8F8AC433F0
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 2/4] brcmfmac: support 4-way handshake offloading for
 WPA/WPA2-PSK in AP mode
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200817073316.33402-3-stanley.hsu@cypress.com>
References: <20200817073316.33402-3-stanley.hsu@cypress.com>
To:     Chung-Hsien Hsu <stanley.hsu@cypress.com>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        brcm80211-dev-list@broadcom.com, brcm80211-dev-list@cypress.com,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        Chung-Hsien Hsu <stanley.hsu@cypress.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-ID: <0101017471cd3cfa-6da1214d-c028-4f22-bf21-a4978f4e650b-000000@us-west-2.amazonses.com>
Date:   Wed, 9 Sep 2020 07:38:30 +0000
X-SES-Outgoing: 2020.09.09-54.240.27.11
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Chung-Hsien Hsu <stanley.hsu@cypress.com> wrote:

> Firmware may have authenticator code built-in. This is detected by the
> driver and indicated in the wiphy features flags. User space can use
> this flag to determine whether or not to provide the pre-shared key
> material in the nl80211 start AP command to offload the 4-way handshake
> in AP mode.
> 
> Signed-off-by: Chung-Hsien Hsu <stanley.hsu@cypress.com>
> Signed-off-by: Chi-Hsien Lin <chi-hsien.lin@cypress.com>

Depends on:

2831a631022e nl80211: support SAE authentication offload in AP mode

Currently in net-next.

-- 
https://patchwork.kernel.org/patch/11716713/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

