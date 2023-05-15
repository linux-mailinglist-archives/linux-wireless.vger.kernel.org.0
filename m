Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDF8703DD0
	for <lists+linux-wireless@lfdr.de>; Mon, 15 May 2023 21:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244534AbjEOToC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 May 2023 15:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243617AbjEOToA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 May 2023 15:44:00 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D72FDC58
        for <linux-wireless@vger.kernel.org>; Mon, 15 May 2023 12:43:59 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id A9EB9980089
        for <linux-wireless@vger.kernel.org>; Mon, 15 May 2023 19:43:57 +0000 (UTC)
Received: from [192.168.100.159] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 0935513C2B0
        for <linux-wireless@vger.kernel.org>; Mon, 15 May 2023 12:43:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 0935513C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1684179837;
        bh=ESIJjeP/9mIJEJrS8e0niyAydWzurxN4H57o9ESSE7w=;
        h=Date:To:From:Subject:From;
        b=Cgm+ZubBPHvDa5XJJ5iJ6oOWkm/RLOn3Hnz1IMWiVGelBUQES1Cln6+m8a4BUUqmY
         rH1UR2xLQHXH/NZzuZWNp3pyeprPphtU1khmTRFLIWGE+7pvlz/sQZu37qUG1zskyK
         7tYZrpfo8SikzCgGajoZR3cMkDRSpeBugPUyk5T4=
Message-ID: <3c897080-aea5-82cb-2136-7d36201cc976@candelatech.com>
Date:   Mon, 15 May 2023 12:43:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To:     linux-wireless <linux-wireless@vger.kernel.org>
Content-Language: en-US
From:   Ben Greear <greearb@candelatech.com>
Subject: Plan to update 'iw' for wifi-7?
Organization: Candela Technologies
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1684179838-0d62CIn9jQNW
X-MDID-O: us5;at1;1684179838;0d62CIn9jQNW;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

 From what I can tell, iw doesn't how any wifi-7 capabilities.  What is the plan to add this?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

