Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A29FA1EE43E
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jun 2020 14:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbgFDMLe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 Jun 2020 08:11:34 -0400
Received: from roobidoo.pudai.com ([216.14.118.130]:52288 "EHLO
        roobidoo.pudai.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728016AbgFDMLe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 Jun 2020 08:11:34 -0400
X-Greylist: delayed 2146 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Jun 2020 08:11:34 EDT
Received: from [71.219.88.243] (port=50695 helo=[10.168.3.124])
        by roobidoo.pudai.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <tim@timhiggins.com>)
        id 1jgo9z-0006tS-KX; Thu, 04 Jun 2020 06:35:47 -0500
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: ax200 very poor performance in stock 5.7.0 and 53.c3 firmware.
From:   Tim Higgins <tim@timhiggins.com>
X-Mailer: iPad Mail (16G183)
In-Reply-To: <c2898228-836e-549b-85ee-8c2d24051912@candelatech.com>
Date:   Thu, 4 Jun 2020 07:35:46 -0400
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <3B9D5022-D95A-4CC3-B8A0-1104358F241E@timhiggins.com>
References: <c2898228-836e-549b-85ee-8c2d24051912@candelatech.com>
To:     Ben Greear <greearb@candelatech.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - roobidoo.pudai.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - timhiggins.com
X-Get-Message-Sender-Via: roobidoo.pudai.com: authenticated_id: tim@timhiggins.com
X-Authenticated-Sender: roobidoo.pudai.com: tim@timhiggins.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



> On Jun 3, 2020, at 11:54 PM, Ben Greear <greearb@candelatech.com> wrote:
> 
> I'm testing an un-modified kernel for a change, and latest firmware that I could find,
> but ax200 is still sucking.
> 
> UDP upload of single ax200 station gets about 1Mbps, and station disconnects
> very often.  TCP download gets about 400Mbps on each of two radios.  UDP download stalls
> often and averages around 1Mbps throughput.  TCP upload also stalls out.
> 
> Previous testing on other kernels has shown problems with other firmware as well.
> 
> I'm requesting 500Mbps UDP speeds.    Requesting only 100Mbps does not help (tested with DL direction only).
> 
> [root@ct523c-0b29 ~]# ethtool -i wlan2
> driver: iwlwifi
> version: 5.7.0
> firmware-version: 53.c31ac674.0 cc-a0-53.ucode
> expansion-rom-version:
> bus-info: 0000:12:00.0
> supports-statistics: yes
> supports-test: no
> supports-eeprom-access: no
> supports-register-dump: no
> supports-priv-flags: no
> 
> 
> Is there any way to disable OFDMA or /ax on the ax200 in case that helps somehow?
> 
> Thanks,
> Ben
Hi Ben,
Try running with no encryption. I know that is not a solution. But it could point to a cause. I've seen disabling encryption make a big difference.
