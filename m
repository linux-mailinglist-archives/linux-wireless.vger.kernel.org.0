Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9FD108DE2
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2019 13:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfKYMbf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Nov 2019 07:31:35 -0500
Received: from a27-187.smtp-out.us-west-2.amazonses.com ([54.240.27.187]:54488
        "EHLO a27-187.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725946AbfKYMbe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Nov 2019 07:31:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574685093;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type;
        bh=wTQkzRVUituDa/6iS8wAISmkIdu8SWe/Gj4Pw0VOWHU=;
        b=FSKsCU3ZRo1fiXJu/vcIySLBQxh7hOMCOnmt6+k2AcEyzN5+Zz/tTKN+5CIVEq5m
        /wLNT6BiR6zhYuGk+tT+xCk/7xhLx2k4nRLIYEs7t7fV0lG86gKlOFlGNZEATmf91Ej
        7a2AgvNVkZlGARgr0JVIXoCbS2IRIQRC6vhYhQMI=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574685093;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:MIME-Version:Content-Type:Feedback-ID;
        bh=wTQkzRVUituDa/6iS8wAISmkIdu8SWe/Gj4Pw0VOWHU=;
        b=aRiT/szg04qdfxTMv4O7h3rceZ0pI/gJw2zmrGEWJmldoPBvH7HqxQRcX5vMFZ45
        Sn1Uy40a/VXHq4GG9z9SrkR7lQe7X3D3Y4SCwDoRzLaAMn1MlRX9FqwtdFjUyJZ5Ii6
        M/EOI3naXmlur80U66/u6yZK2JyXfBHNZVYifSh0=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6A03DC447BD
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 00/49] ath11k: driver for Qualcomm IEEE 802.11ax devices
References: <1573810153-29623-1-git-send-email-kvalo@codeaurora.org>
        <0101016e975ec74d-5c7043cf-f7c1-4301-939a-783203f9c80d-000000@us-west-2.amazonses.com>
Date:   Mon, 25 Nov 2019 12:31:32 +0000
In-Reply-To: <0101016e975ec74d-5c7043cf-f7c1-4301-939a-783203f9c80d-000000@us-west-2.amazonses.com>
        (Kalle Valo's message of "Sat, 23 Nov 2019 08:26:41 +0000")
Message-ID: <0101016ea28bac43-f72dbf97-32f4-4db4-a6d3-622b8f01f644-000000@us-west-2.amazonses.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-SES-Outgoing: 2019.11.25-54.240.27.187
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> writes:

> Kalle Valo <kvalo@codeaurora.org> writes:
>
>> ath11k is a new driver for Qualcomm IEEE 802.11ax devices, first
>> supporting only IPQ8074 SoC using the shared memory AHB bus. ath11k
>> uses mac80211 and supports AP, Station and Mesh modes.
>>
>> Even though ath11k has some similar code as with ath10k (especially
>> the WMI layer) it was concluded to be simpler to have a "clean start"
>> for ath11k code base and not try to share the code with ath10k. This
>> makes maintenance easier and avoids major changes in ath10k, which
>> would have significantly increased the risk of regressions in existing
>> setups.
>>
>> Even though the driver is very similar with ath10k but there are major
>> differences as well. The datapath is completely different. ath11k
>> supports multiple MACs, called "soc" in the firmware interface. And
>> there's only one WMI interface to support.
>>
>> Currently ath11k supports only IEEE 802.11ac mode, but patches for
>> 802.11ax are available and they will be submitted after ath11k is
>> accepted to upstream.
>>
>> The firmware images are available from ath11k-firmware repository but
>> they will be also submitted to linux-firmware:
>>
>> https://github.com/kvalo/ath11k-firmware
>
> I also added to the commit log the version which was used in testing:
>
> WLAN.HK.2.1.0.1-00629-QCAHKSWPL_SILICONZ-1
>
>> --------------[cut]-------------------[cut]-----------------
>>
>> I have split the driver into multiple patches for easier review, but
>> the final version will be split into three commits:
>>
>> 1. adding Documentatio/devicetree/bindings/net/wireless/qcom,ath11k.yaml
>>
>> 2. adding drivers/net/wireless/ath/ath11k/ with the commit log being the
>>    text before the cut line above.
>>
>> 3. adding ath11k entry to MAINTAINERS file
>>
>> This version is based on commit ad10d2ff619f0797cb102b2ff488429d3f8e4a8a
>> from ath11k-bringup branch on my ath.git tree:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/log/?h=ath11k-bringup
>>
>> This patchset applies to wireless-drivers-next but needs
>> CONFIG_COMPILE_TEST, CONFIG_REMOTEPROC AND CONFIG_QCOM_QMI_HELPERS to
>> be able to compile on x86.
>>
>> Please review and comment.
>
> I have now prepared the three commits and they are in the pending
> branch for build testing:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=20bddf19da715842fe24c8e9990ae1b75825c747
>
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=461a5c86cfa562bd3c4a8f6bec9a54c406540e87
>
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=8710785df81b8b57e62a71e9048c111a7db98005
>
> In the next few days I'll apply these to ath-next branch and queue for v5.6.

Manually applied to ath-next branch of my ath.git tree:

dae0978d4174 dt: bindings: net: add qcom,ath11k.yaml
d5c65159f289 ath11k: driver for Qualcomm IEEE 802.11ax devices
02fdd85da2ce MAINTAINERS: add ath11k

Thanks everyone!

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
