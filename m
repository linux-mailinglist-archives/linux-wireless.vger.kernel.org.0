Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897467D716E
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Oct 2023 18:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234608AbjJYQGB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Oct 2023 12:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234535AbjJYQF7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Oct 2023 12:05:59 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC490132
        for <linux-wireless@vger.kernel.org>; Wed, 25 Oct 2023 09:05:57 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id A5D86C0066;
        Wed, 25 Oct 2023 16:05:52 +0000 (UTC)
Received: from [192.168.100.159] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 4F8EB13C2B0;
        Wed, 25 Oct 2023 09:05:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 4F8EB13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1698249951;
        bh=AgjZ53EMHNKLAl5xmVoTnTpDxBqhhdJ49QdIBGpzDcY=;
        h=Date:To:Cc:From:Subject:From;
        b=BKqjHHtp1+T1eeoZjMyhT0RKCL65ERUmsFyLnYAtyHJPVOMjd5FtDmmWJOzzbn7R3
         QMjN3NtN3vCoP91otOhYJh7ETjBIuVy2lFC28V44lJWEp87iCGvHG2GcqefUiaRnPk
         0b0jutKwP/YBQQMqi0pdB2YnNBV7O2B4H5+Rsqhk=
Message-ID: <2fb78387-d226-3193-8ca7-90040561b9ad@candelatech.com>
Date:   Wed, 25 Oct 2023 09:05:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     linux-wireless <linux-wireless@vger.kernel.org>
Cc:     mingyen.hsieh@mediatek.com
From:   Ben Greear <greearb@candelatech.com>
Subject: Regression wireless-next: mt7921: update the channel usage when the
 regd domain changed
Organization: Candela Technologies
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1698249953-MgnXGeUqdbW5
X-MDID-O: us5;ut7;1698249953;MgnXGeUqdbW5;<greearb@candelatech.com>;29213b6a21c28d0bb86e949ab8f33825
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I noticed mt7922 radios would no longer enable 6e band in wireless-next.

My test system has Intel radios and mt7922 radios in it.  I bisected to the commit
below.  It looks like that patch can disable 6e based on regdom change, but cannot
enable 6e again in case regdom changes back to something that supports 6e.

Intel tri-band radios disable 6e by default, then enable it after scanning
US regdom beacons.  Maybe that regdom changing by Intel helps break the mt7922
with the below patch applied?

commit 09382d8f8641bc12fffc41a93eb9b37be0e653c0
Author: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Date:   Sat Sep 30 10:25:09 2023 +0800

     wifi: mt76: mt7921: update the channel usage when the regd domain changed

     The 5.9/6GHz channel license of a certain platform device has been
     regulated in various countries. That may be difference with standard
     Liunx regulatory domain settings. In this case, when .reg_notifier()
     called for regulatory change, mt792x chipset should update the channel
     usage based on clc or dts configurations.

     Channel would be disabled by following cases.
     * clc report the particular UNII-x is disabled.
     * dts enabled and the channel is not configured.

     Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
     Co-developed-by: Deren Wu <deren.wu@mediatek.com>
     Signed-off-by: Deren Wu <deren.wu@mediatek.com>
     Signed-off-by: Felix Fietkau <nbd@nbd.name>

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

