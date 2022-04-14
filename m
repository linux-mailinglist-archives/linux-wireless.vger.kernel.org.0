Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38061501807
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Apr 2022 18:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349012AbiDNQAF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Apr 2022 12:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350375AbiDNPkZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Apr 2022 11:40:25 -0400
Received: from mail.redfish-solutions.com (mail.redfish-solutions.com [45.33.216.244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A3036331
        for <linux-wireless@vger.kernel.org>; Thu, 14 Apr 2022 08:20:01 -0700 (PDT)
Received: from smtpclient.apple (macbook3.redfish-solutions.com [192.168.1.18])
        (authenticated bits=0)
        by mail.redfish-solutions.com (8.16.1/8.16.1) with ESMTPSA id 23EFJwpe012157
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Apr 2022 09:19:58 -0600
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: What's required for WiFi 6 Certified Location service?
From:   Philip Prindeville <philipp_subx@redfish-solutions.com>
In-Reply-To: <031931ec-e14b-2b36-2f9c-73b4b9a2e462@quicinc.com>
Date:   Thu, 14 Apr 2022 09:19:58 -0600
Cc:     linux-wireless@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <16F51907-EF45-4B33-A5D6-50D23F4C09B3@redfish-solutions.com>
References: <D6C016DA-086E-4CB1-80DA-A40839B714AE@redfish-solutions.com>
 <031931ec-e14b-2b36-2f9c-73b4b9a2e462@quicinc.com>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: Apple Mail (2.3696.80.82.1.1)
X-Scanned-By: MIMEDefang 2.85 on 192.168.4.3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



> On Apr 12, 2022, at 2:03 PM, Jeff Johnson <quic_jjohnson@quicinc.com> wrote:
> 
> On 4/12/2022 12:40 PM, Philip Prindeville wrote:
>> Is anyone in the Linux kernel community working on an FTM implementation?
> 
> Start by looking at the usage of struct cfg80211_pmsr_request_peer and you'll find an in-tree Intel implementation.
> 
> Also I expect that every Android vendor has an out-of-tree implementation.


Interesting.

I guess a lot of commercial SoHo routers won't have support until the Ath9k, etc. families have support added.  Not clear if/when that will happen.

-Philip

