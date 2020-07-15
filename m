Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B013220245
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jul 2020 04:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbgGOCUj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Jul 2020 22:20:39 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:52346 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726928AbgGOCUi (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Jul 2020 22:20:38 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594779638; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=XE045Q4bXReg1Te68ZyHgJsNayVf9cske1K6noKWjeI=;
 b=udS6ch8CpDMwNIvYIoEE7boB/d4yJ2bkxKM6ocbaEZQ6zQ6S1lOortN32aFlKbGZYjYddiwA
 C++NbnFhxbAj15eFknNnR8tsAeZ5+ewVxLqAU+ZuZury55ue1JleN8mfqTPtA71wIVghtSnA
 0wr207IvJHSQHgKujx/QIfedCI8=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n15.prod.us-east-1.postgun.com with SMTP id
 5f0e67e8c7a053446a92b047 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 15 Jul 2020 02:20:24
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 64EB1C43387; Wed, 15 Jul 2020 02:20:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: rmanohar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 010ADC433C8;
        Wed, 15 Jul 2020 02:20:22 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 14 Jul 2020 19:20:22 -0700
From:   Rajkumar Manoharan <rmanohar@codeaurora.org>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     kvalo@codeaurora.org, mkenna@codeaurora.org,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Stefan Lippers-Hollmann <s.l-h@gmx.de>,
        linux-wireless-owner@vger.kernel.org
Subject: Re: [PATCH v5.8] ath10k: Fix NULL pointer dereference in AHB device
 probe
In-Reply-To: <20200714205802.17688-1-hauke@hauke-m.de>
References: <20200714205802.17688-1-hauke@hauke-m.de>
Message-ID: <03aa088e5d2b46f570372f72c430f93f@codeaurora.org>
X-Sender: rmanohar@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-07-14 13:58, Hauke Mehrtens wrote:
> This fixes a NULL pointer dereference in the probe path for AHB 
> devices.
> There attr parameter in the ath10k_ce_alloc_pipe() function is not
> initialized, but accessed. This function is called by
> ath10k_pci_setup_resource() which is called by ath10k_ahb_probe().
> 
> The struct ath10k_pci is also used for AHB devices and not only for PCI
> devices.
> 
> The initialization of the new members of struct ath10k_pci is moved to
> ath10k_pci_setup_resource() which is used by the PCI and the AHB code.
> 
> This also fixes a use after free bug in ath10k_pci_remove() when ar_pci
> is accessed after ath10k_core_destroy() was called, which calls
> ieee80211_free_hw() and frees this memory.
> 
> This fixes the following bug seen with backports-5.8-rc2 on OpenWrt on 
> a
> IPQ4019 device:
> 
Thanks Hauke for taking care of this. Your change LGTM.

-Rajkumar
