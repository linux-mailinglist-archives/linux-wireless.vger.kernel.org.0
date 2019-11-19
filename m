Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A830B102DA5
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2019 21:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfKSUkH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Nov 2019 15:40:07 -0500
Received: from roobidoo.pudai.com ([216.14.118.130]:39750 "EHLO
        roobidoo.pudai.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726711AbfKSUkH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Nov 2019 15:40:07 -0500
X-Greylist: delayed 4146 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Nov 2019 15:40:06 EST
Received: from [71.219.63.218] (port=3235 helo=[10.168.3.100])
        by roobidoo.pudai.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <tim@smallnetbuilder.com>)
        id 1iX9DH-0002wQ-3f; Tue, 19 Nov 2019 13:30:59 -0600
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        linuxwifi@intel.com
Cc:     tim@smallnetbuilder.com
From:   Tim Higgins <tim@smallnetbuilder.com>
Subject: Fix for AX200 throughput problems?
Message-ID: <6a4a097c-d505-9ff9-fdd7-0a6bd09dc582@smallnetbuilder.com>
Date:   Tue, 19 Nov 2019 14:30:59 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - roobidoo.pudai.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - smallnetbuilder.com
X-Get-Message-Sender-Via: roobidoo.pudai.com: authenticated_id: tim@timhiggins.com
X-Authenticated-Sender: roobidoo.pudai.com: tim@timhiggins.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

There have been a few bugs filed in Bugzilla about low AX200 throughput (205061, 205109, 
205077). In my experience, TCP/IP downlink throughput is significantly lower than that produced 
by the Windows 10 driver. Uplink throughput is essentially zero, even though the STA remains 
associated.

Can anyone provide guidance as to when the AX200 throughput performance will be fixed? This 
product is a key element for 802.11ax test and measurement product development, but is only 
usable for sniffing with the current throughput performance.

Thanks,
Tim Higgins
