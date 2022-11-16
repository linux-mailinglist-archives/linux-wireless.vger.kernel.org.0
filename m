Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2B062C0AB
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Nov 2022 15:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbiKPOQd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Nov 2022 09:16:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiKPOQc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Nov 2022 09:16:32 -0500
Received: from mog.warmcat.com (mog.warmcat.com [178.170.10.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BC9A1DF57
        for <linux-wireless@vger.kernel.org>; Wed, 16 Nov 2022 06:16:30 -0800 (PST)
Received: from mx.warmcat.com (host31-53-12-215.range31-53.btcentralplus.com [31.53.12.215])
        by mog.warmcat.com (Postfix) with ESMTPSA id 63AA6135627;
        Wed, 16 Nov 2022 14:16:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mog.warmcat.com 63AA6135627
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=warmcat.com;
        s=default; t=1668608189;
        bh=1kmXP/9pkccllYjUBcLqfWbZ2VvGpPdVKCYWpNSbfI0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PVNpDjB+Ly9KtARAcnhyLy6L8aLb8HreP+zR7n59BIvFOdWSASCvbLlkR6vw+AUdp
         +ycwddHgj/8E1ZWcvxkDM04FSnIkqZQwBCuGJFBua9KTi4LJsky6MqG4sC2OPGQaSs
         bm2EEzKXg9lQFyrQXAinrCRMWG4LOqDYKloq/cK4=
Received: from [192.168.4.115] (unknown [192.168.4.115])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by mx.warmcat.com (Postfix) with ESMTPSA id 245032A00EA;
        Wed, 16 Nov 2022 14:16:28 +0000 (GMT)
Message-ID: <2897b8ab-1cd6-6bd3-b0b5-636913ccae45@warmcat.com>
Date:   Wed, 16 Nov 2022 14:16:26 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: AP6275 / bcm43752 pcie on mainline brcmf
Content-Language: en-US
To:     Shengyu Qu <wiagn233@outlook.com>,
        Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc:     franky.lin@broadcom.com, linux-wireless@vger.kernel.org
References: <TY3P286MB26114DD461F50814980453E598029@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <08416710-655a-c87c-a599-3fe2563f7de4@warmcat.com>
 <18470a1e910.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <TY3P286MB26115A58795F264893CCB40198029@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <184720fc920.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <TY3P286MB26118BD94839F752CADCCF5298079@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
From:   Andy Green <andy@warmcat.com>
In-Reply-To: <TY3P286MB26118BD94839F752CADCCF5298079@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 11/16/22 12:25, Shengyu Qu wrote:

> Got a new version of downstream driver and firmware here: https://gitlab.com/rk3588_linux/linux/external/rkwifibt/-/tree/linux-5.10-gen-rkr3.4

The AP6275 PCIE ones there are the firmware files from the rockchip Sept 
SDK drop that I started with... they give the behaviour that the 
sharedram address probed from the device is

[    3.744635] brcmfmac: brcmf_pcie_download_fw_nvram: sharedram_addr 
0xfa1a05e5

and shortly after sending the nvram data

[    9.876580] brcmfmac 0002:21:00.0: brcmf_pcie_download_fw_nvram: FW 
failed to initialize: 0xfa1a05e5

-Andy

