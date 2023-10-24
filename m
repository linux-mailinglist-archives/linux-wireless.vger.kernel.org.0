Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9CED7D5A8B
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Oct 2023 20:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344099AbjJXSbt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Oct 2023 14:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343802AbjJXSbs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Oct 2023 14:31:48 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19CAB9F
        for <linux-wireless@vger.kernel.org>; Tue, 24 Oct 2023 11:31:45 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 79382180086
        for <linux-wireless@vger.kernel.org>; Tue, 24 Oct 2023 18:31:43 +0000 (UTC)
Received: from [192.168.100.159] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id C2EA813C2B0
        for <linux-wireless@vger.kernel.org>; Tue, 24 Oct 2023 11:31:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com C2EA813C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1698172302;
        bh=jOd6SvZJOcREtioF+ESY9ZER5ZXS5TgysP/x8wYiCvk=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=YJxZrTiBYk9kR+uuM+Zfu5RZ+IMMAye3Nkqt7CN5dZm1IEheLiWsWzaSQnMW26tdg
         O5NUk84+7HpEgTH511wfBudn8GKO1UUnwRzkB3iCFZRtpJmAho2iIWsjrDySqKDfzD
         QrTYCUEDT+/cV+B/IUNPJBQqHIeP/PmAPQEWkZfA=
Message-ID: <3a40a14e-c597-e38d-f66e-b56a6f19ba87@candelatech.com>
Date:   Tue, 24 Oct 2023 11:31:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] wifi: mac80211: ethtool: use best available link for
 default stats.
Content-Language: en-US
To:     linux-wireless <linux-wireless@vger.kernel.org>
References: <20231020152353.3705759-1-greearb@candelatech.com>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <20231020152353.3705759-1-greearb@candelatech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1698172304-mNt8XVf3OYtf
X-MDID-O: us5;at1;1698172304;mNt8XVf3OYtf;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/20/23 08:23, greearb@candelatech.com wrote:
> From: Ben Greear <greearb@candelatech.com>
> 
> Best link is the link with the highest state (ie, associated)
> and if multiple links have same state, the highest
> frequency wins.
> 
> This makes current ethtool stats more useful.  Per-link
> ethtool stats can be added later.

The kernel robot is correct, this patch is buggy and would crash with a 2+ link
situation.  I'll send v3, though I don't have an AP that actually advertises > 1 link
so difficult to test well...

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


