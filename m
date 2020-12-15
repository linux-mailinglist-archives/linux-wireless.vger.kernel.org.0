Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED49B2DB72E
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Dec 2020 00:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725786AbgLOX6t (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Dec 2020 18:58:49 -0500
Received: from mail2.candelatech.com ([208.74.158.173]:56148 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgLOXaV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Dec 2020 18:30:21 -0500
Received: from [192.168.254.6] (unknown [50.46.158.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id BA53D13C2B0
        for <linux-wireless@vger.kernel.org>; Tue, 15 Dec 2020 15:29:40 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com BA53D13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1608074980;
        bh=Wc0Jh+mk2kOXVWVj1FYum6X+YMfNMdhAXilc9qPqPBk=;
        h=To:From:Subject:Date:From;
        b=TZr3AXfiWSbRWb8/UeMMwvjeDwTq+40fcz3ZcXAVeQtqBlxSLm2uHeRKGGQJPLJp9
         7MQD62LCccdnOw5QHbgUiN9fZrZ070wF38IIzDx35jtB9wtBl7Id70ZTQkK9Zpd4Xe
         /jUeTDZIhVG4K+wqAaP1TNyuKG+yt6e51BrM4y/o=
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
From:   Ben Greear <greearb@candelatech.com>
Subject: ax200 performance results: 5.4 vs 5.10 kernel.
Organization: Candela Technologies
Message-ID: <e1415d52-bf07-c403-7265-96f097ee4e89@candelatech.com>
Date:   Tue, 15 Dec 2020 15:29:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

TLDR:  5.10 seems to have performance regressions, especially in upload (ax200 sending to AP)
direction with TCP.

Here's some results from testing ax200 on 5.4 and 5.10 kernels.

Kernels can be found here:
https://github.com/greearb?tab=repositories

I have a system with 4 ax200 NICs plus some ath10k radios (ath10k idle in this
test case).  AP is ath11k 8x8 hawkeye.

5.4 (using out-of-tree backports ax200 driver since in-kernel driver was very unstable for us)
I am not sure the exact version I backported, it was back in 6/8/2020 of this year.

single station download: 900Mbps
4 stations download: 900Mbps
single station upload: 775Mbps
4 stations upload: 700Mbps


5.10 (we first tested in-kernel driver, and that showed poor upload, so then I tried
hacking the backports release/core56 ax200 driver into 5.10.  Detailed testing results
below are from the hacked in backports driver)

single station download: 500Mbps
4 stations download: 900Mbps
single station upload: 450Mbps
4 stations upload: 400Mbps

UDP ran similarly.  TCP with 350 streams ran similarly.

As always with wifi, there are a million things that could be weird
about my test case.  If someone can do similar testing and report
results, please do so we can compare.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
