Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 452CBB812F
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2019 21:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392252AbfISTJA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Sep 2019 15:09:00 -0400
Received: from roobidoo.pudai.com ([216.14.118.130]:59188 "EHLO
        roobidoo.pudai.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2392247AbfISTJA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Sep 2019 15:09:00 -0400
X-Greylist: delayed 3640 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Sep 2019 15:08:59 EDT
Received: from [71.219.36.120] (port=2568 helo=[10.168.3.100])
        by roobidoo.pudai.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <tim@smallnetbuilder.com>)
        id 1iB0qp-0000FX-LW; Thu, 19 Sep 2019 13:08:19 -0500
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     tim@smallnetbuilder.com
From:   Tim Higgins <tim@smallnetbuilder.com>
Subject: Can Intel AX200 sniff UL OFDMA ?
Message-ID: <82af1531-6f53-364c-46ed-e011455e9c01@smallnetbuilder.com>
Date:   Thu, 19 Sep 2019 14:08:18 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
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

Hello,

I have been using the debug hw_sniffer_params file to tune the AX200 to a specific AID. This 
works well for capturing OFDMA DL. But I have yet to capture any UL OFDMA frames, or at least I 
don't think I have.

I am looking for QoS data frames that have HE_MU PPDU format. Is this correct?
I can see plenty of HE_SU PPDU frames from STA to AP, but no HE_MU uplink.

Am I looking for the wrong thing or can the AX200 not sniff OFDMA UL?

Thanks,
Tim Higgins
