Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDBB2AAABD
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2019 20:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389317AbfIESU0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Sep 2019 14:20:26 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:40852 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730926AbfIESU0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Sep 2019 14:20:26 -0400
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 03286104B
        for <linux-wireless@vger.kernel.org>; Thu,  5 Sep 2019 11:20:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 03286104B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1567707626;
        bh=xklPLRHh0uXJZ5jVbsxtjE1xQXJy2cW88dXK+fpQfGE=;
        h=To:From:Subject:Date:From;
        b=bLOgyVx4xpu1dfwUHkAbnMEYz+ZoJBa1txZ313nNhCgMK/AWeUJq+zc4Tii77QuJp
         n2/b9HYlsV4/X7pjQbEUgscvo5NpYRac2aI04tcRdb9v2swe+62YetSdOjsEaR3Uhs
         Fz4WUukJbuxSO/2WITQ22QPJdo1maQC7TT93NPL4=
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
From:   Ben Greear <greearb@candelatech.com>
Subject: iw scan dump for /AX attributes?
Organization: Candela Technologies
Message-ID: <8afa882e-64de-7c8b-49f4-ac318f395102@candelatech.com>
Date:   Thu, 5 Sep 2019 11:20:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

Is anyone working on getting iw to print out /AX (HE) related
info?  As far as I can tell, it does not do so currently, but maybe
I am doing something wrong.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

