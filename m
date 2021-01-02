Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCB912E8828
	for <lists+linux-wireless@lfdr.de>; Sat,  2 Jan 2021 18:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbhABRsb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 2 Jan 2021 12:48:31 -0500
Received: from mail2.candelatech.com ([208.74.158.173]:60040 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726625AbhABRsb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 2 Jan 2021 12:48:31 -0500
Received: from [192.168.254.6] (unknown [50.46.152.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 51CAF13C2B0
        for <linux-wireless@vger.kernel.org>; Sat,  2 Jan 2021 09:47:50 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 51CAF13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1609609670;
        bh=i4x5LpyJoGrep1Xp2d/qh/Bs7ot8o7xBxh8tABu1mG4=;
        h=To:From:Subject:Date:From;
        b=J+t90rxM4IPYkZZPylnAykzw90fuyzaNfNEUPjd8jKhD6sn/0/f6dfVvqlJMokMF/
         mEpJgeDTVcrmT1I1bW0RKImk8Ku3SyFlvh49ESUDoROoIRF1vVGVROwppubhRjZo+0
         eoXRRGCYeLEWcFsltE2To/d1g2rJxKiDRY0CAg6o=
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
From:   Ben Greear <greearb@candelatech.com>
Subject: ax200: How to set rateset?
Organization: Candela Technologies
Message-ID: <a70400d5-289e-0daa-83b9-a472afc72453@candelatech.com>
Date:   Sat, 2 Jan 2021 09:47:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello ax200 folks,

I've been looking into how to set the ax200/ax210 NIC to use a specific
rateset.  There is some debugfs hooks in the driver that appear to allow
this sort of behaviour, but they are not enabled because the ax210 firmware
uses firmware based rate-ctrl.

Is there any way to tell it to send with only a single rate for testing
purposes?  My end goal is to do receiver sensitivity testing, so I need
a way to force the MCS, NSS, guard interval and other tx-rate related
settings.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
