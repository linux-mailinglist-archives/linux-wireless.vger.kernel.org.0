Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70CDC4E9CBA
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Mar 2022 18:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241550AbiC1Qvx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Mar 2022 12:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236419AbiC1Qvw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Mar 2022 12:51:52 -0400
X-Greylist: delayed 363 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 28 Mar 2022 09:50:10 PDT
Received: from simonwunderlich.de (simonwunderlich.de [IPv6:2a01:4f8:c17:e8c0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4299641325
        for <linux-wireless@vger.kernel.org>; Mon, 28 Mar 2022 09:50:09 -0700 (PDT)
Received: from [IPv6:2003:c5:974d:4090::607] (p200300C5974d40900000000000000607.dip0.t-ipconnect.de [IPv6:2003:c5:974d:4090::607])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by simonwunderlich.de (Postfix) with ESMTPSA id D2F91FA768;
        Mon, 28 Mar 2022 18:44:01 +0200 (CEST)
To:     akolli@codeaurora.org
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        periyasa@codeaurora.org
References: <1612946530-28504-7-git-send-email-akolli@codeaurora.org>
Subject: Re: [PATCH 06/11] ath11k: add static window support for register
 access
From:   Hamdi Issam <ih@simonwunderlich.de>
Message-ID: <4c708ea3-d027-aa01-e157-17a29889ac44@simonwunderlich.de>
Date:   Mon, 28 Mar 2022 18:44:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1612946530-28504-7-git-send-email-akolli@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

I was trying to read values of timers from some offsets on the QCN9074, 
but I get every time an invalid values (0xffffffff):
This is example of my code:

#define QCN9000_WLAON_GLOBAL_COUNTER_CTRL3      0x1F80118
#define QCN9000_WLAON_GLOBAL_COUNTER_CTRL4      0x1F8011C
#define QCN9000_WLAON_GLOBAL_COUNTER_CTRL5      0x1F80120

#define QCN9000_TIME_SYNC_ENABLE                0x80000000
#define QCN9000_TIME_SYNC_CLEAR                 0x0
.
.
.
ath11k_pci_write32(ab, QCN9000_WLAON_GLOBAL_COUNTER_CTRL5, 
QCN9000_TIME_SYNC_CLEAR);
ath11k_pci_write32(ab, QCN9000_WLAON_GLOBAL_COUNTER_CTRL5, 
QCN9000_TIME_SYNC_ENABLE);
low = ath11k_pci_read32(ab, QCN9000_WLAON_GLOBAL_COUNTER_CTRL3);
high = ath11k_pci_read32(ab, QCN9000_WLAON_GLOBAL_COUNTER_CTRL4);
.
.

The low and the high parameters always equal to "0xffffffff".

When I made some debugging. I found that the issue is related to 
"static_window_map" developed in the commit 
"480a73610c95511e42fb7d0359b523f66883e51a: ath11k: add static window 
support for register access" and enabled for QCN9074 in this commit 
"4e80946197a83a6115e308334618449b77696d6a: ath11k: add qcn9074 pci 
device support".
When I disabled the "static_window_map" 
(ab->bus_params.static_window_map = false;) for QCN9074, in that case I 
was able to get the correct values.
So it seems that there's an issue of reading some reg when 
static_window_map is enabled.
I need your help to solve this issue.

Regards,
Issam

