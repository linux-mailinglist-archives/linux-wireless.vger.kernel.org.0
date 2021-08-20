Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAF793F31AD
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Aug 2021 18:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbhHTQoe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Aug 2021 12:44:34 -0400
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.164]:60476 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229784AbhHTQod (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Aug 2021 12:44:33 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.51.166])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 8A9441A0065
        for <linux-wireless@vger.kernel.org>; Fri, 20 Aug 2021 16:43:54 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 60671900066
        for <linux-wireless@vger.kernel.org>; Fri, 20 Aug 2021 16:43:54 +0000 (UTC)
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 87CEF13C2B1
        for <linux-wireless@vger.kernel.org>; Fri, 20 Aug 2021 09:43:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 87CEF13C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1629477833;
        bh=reLbaoW+xv7HVA4OQzl/IXK+kPVoSeKdMEu+xBbVe7s=;
        h=To:From:Subject:Date:From;
        b=jr0moSFJCHq1Whgpcz839QQrWNmJ4u1CMytApUD/I+O4WaysuLJykH+dQqr7606kI
         Q56/5b6Ndk/9ZfXsE9k9MpiCT2OhDRDhfF0Q00kBiFOrHsgz9syPnYM9xblTgTuFMY
         7GxHOilDUXVJvBoSx09jtAbiPF5BIgf0M7SdEXDk=
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
From:   Ben Greear <greearb@candelatech.com>
Subject: CAC question: DFS -> non-dfs -> DFS
Organization: Candela Technologies
Message-ID: <a0464631-22f3-be43-a7cd-7623bdc640e8@candelatech.com>
Date:   Fri, 20 Aug 2021 09:43:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-MDID: 1629477835-fC5lSee2o5BR
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

While poking at the MTK driver and trying to fix some CAC bugs in it,
I noticed the following:

Select ch 100, which enables DFS CAC logic.  Wait for that to finish.
Then select CH 36 (disable DFS)
Then select ch 100 again, and the chandef->chan->dfs_state is set back to 0
which I think means we must do CAC again.

I was expecting in this case that the DFS state would be set to NL80211_DFS_AVAILABLE
instead, since CAC just passed a few minutes prior?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

