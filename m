Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5A2425B6C3
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Sep 2020 00:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgIBWyf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Sep 2020 18:54:35 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:35614 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgIBWye (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Sep 2020 18:54:34 -0400
Received: from [192.168.254.6] (unknown [50.34.202.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id A362A13C2B0;
        Wed,  2 Sep 2020 15:54:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com A362A13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1599087273;
        bh=pHxVwMxACrBCil+q7AoKu4vAQ8nmnpHC4/aVbpTswGM=;
        h=To:From:Subject:Date:From;
        b=WChM0vVJSxgPWIqFy1cQ8hOP5BTpiSNwxr9TPS54zHNLIV4Xd3odBsQxEygE9irDW
         L4MqKvpkbR3Wf87blUQFXZWrduk5p3+kcl2DHZ6OYF0yKdZSCyh1n2G2cZPGrflu8Z
         JX3ntO5/Aw5JCHQcVq+BdQMYAqzxDczCjqJDUxDQ=
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Wen Gong <wgong@codeaurora.org>
From:   Ben Greear <greearb@candelatech.com>
Subject: lockdep splat in kvallo ath tree
Organization: Candela Technologies
Message-ID: <0ef69472-9613-c265-0635-ff2ef0cf274f@candelatech.com>
Date:   Wed, 2 Sep 2020 15:54:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The patch below adds a call to ath10k_debug_fw_stats_request(ar),
which expects ar->conf_mutex to be held, but it is *not* held in
this code path.  This leads to warnings when lockdep is enabled.


greearb@bendt7 ath10k]$ git show 4913e675630ec
commit 4913e675630ec1a15c92651f426a63755c71b91b
Author: Wen Gong <wgong@codeaurora.org>
Date:   Thu Apr 23 10:27:58 2020 +0800

     ath10k: enable rx duration report default for wmi tlv

     When run command "iw dev wlan0 station dump", the rx duration is 0.
     When firmware indicate WMI_UPDATE_STATS_EVENTID, extended flag of
     statsis not set by default, so firmware do not report rx duration.


Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
