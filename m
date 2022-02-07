Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627EF4ACAF0
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Feb 2022 22:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236763AbiBGVLQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Feb 2022 16:11:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbiBGVLO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Feb 2022 16:11:14 -0500
X-Greylist: delayed 123 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 13:11:13 PST
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29DFAC06173B
        for <linux-wireless@vger.kernel.org>; Mon,  7 Feb 2022 13:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644268273; x=1675804273;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pgdzWw4Lqk/KZ+mo1Wj/e3osdS5mieE8gc5aFCdE4A4=;
  b=TacSDbf0ecXYwjoGP1s7chGZV70rbYtKlgcSyRc/wAwEgerMq7uKKnaQ
   79OmQYC/v0S4uPuMCkaukJ0x/4DzNmDrCW73DRMUHIrMzQLr1lpXJNXCW
   HndmN1HaeV4BjVtCN9dab2prZW4yKsfCw9KMn8mya3FYGdrIpkq0f0AoC
   w=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 07 Feb 2022 13:09:10 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2022 13:09:10 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 7 Feb 2022 13:09:10 -0800
Received: from [10.48.246.62] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Mon, 7 Feb 2022
 13:09:09 -0800
Message-ID: <eb059b8c-1a2b-f1f7-d446-103863e2f318@quicinc.com>
Date:   Mon, 7 Feb 2022 13:09:09 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 04/19] ieee80211: Add EHT (802.11be) definitions
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-wireless@vger.kernel.org>
CC:     Veerendranath Jakkam <quic_vjakkam@quicinc.com>,
        Ilan Peer <ilan.peer@intel.com>,
        Jia Ding <quic_jiad@quicinc.com>,
        Mordechay Goodstein <mordechay.goodstein@intel.com>,
        Sriram R <quic_srirrama@quicinc.com>
References: <20220204220255.448224-1-johannes@sipsolutions.net>
 <20220204230119.1ee92202ac30.Id30a3ef2844b296efbd5486fe1da9ca36a95c5cf@changeid>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20220204230119.1ee92202ac30.Id30a3ef2844b296efbd5486fe1da9ca36a95c5cf@changeid>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2/4/2022 2:02 PM, Johannes Berg wrote:
> From: Ilan Peer <ilan.peer@intel.com>
> 
> Based on Draft P802.11be_D1.3.

Since IEEE P802.11be™/D1.4, January 2022 is out, can we make sure all 
definitions are still aligned, and update the document reference in all 
patches that have a reference?
