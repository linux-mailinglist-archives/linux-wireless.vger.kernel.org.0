Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A54C17EE550
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Nov 2023 17:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbjKPQj6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Nov 2023 11:39:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbjKPQj5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Nov 2023 11:39:57 -0500
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B3FD50
        for <linux-wireless@vger.kernel.org>; Thu, 16 Nov 2023 08:39:53 -0800 (PST)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 8E7752C006F;
        Thu, 16 Nov 2023 16:39:50 +0000 (UTC)
Received: from [192.168.100.159] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 4D94013C2B0;
        Thu, 16 Nov 2023 08:39:48 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 4D94013C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1700152788;
        bh=lqFkbOeDdddlGwzgfrOXWlYTNvaggtjp/NTi2jr+pcU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lg/DomCvVm9nGLdxkdTg1qlmSWOUAEiKtTT/JM8p4nUmUUvMohPW049I1vzSLzuMA
         nHrUL7xVlWUd8b47sx0RwxGPpE08uKC4d/7VtiqaUoJwzYSO9r0fmU3M89C0p36J8d
         CAj3MkrxzHqQ/FaU16goo/U1Vv4IEMhkr9CvZf2Q=
Message-ID: <91f52826-8020-f865-1b50-bc1b6541cbea@candelatech.com>
Date:   Thu, 16 Nov 2023 08:39:45 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: iwlwifi firmware updates 2023-11-16-fixed
Content-Language: en-US
To:     "Greenman, Gregory" <gregory.greenman@intel.com>,
        "linux-firmware@kernel.org" <linux-firmware@kernel.org>
Cc:     "jwboyer@kernel.org" <jwboyer@kernel.org>,
        "Yang, You-Sheng" <vicamo.yang@canonical.com>,
        "Hutchings, Ben" <ben@decadent.org.uk>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>,
        "Ben Ami, Golan" <golan.ben.ami@intel.com>,
        "kyle@infradead.org" <kyle@infradead.org>,
        "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
References: <877cd7e05d187b48ec2615c7b4c1def200370eef.camel@intel.com>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <877cd7e05d187b48ec2615c7b4c1def200370eef.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1700152792-WoRDLNMy4ikO
X-MDID-O: us5;at1;1700152792;WoRDLNMy4ikO;<greearb@candelatech.com>;c4cb9ae18b457cd2373b30bda2d9c03e
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 11/16/23 02:26, Greenman, Gregory wrote:
> Hi,
> 
> This contains a second fix for core83-55 firmware which had a signing issue.
> It should be working this time, sorry for the mess.
> 
> Please pull or let me know if there are any issues.

This firmware will boot the radios on my systems, at least.

Thanks,
Ben

> 
> Thanks,
> Gregory
> 
> 
> The following changes since commit 124b66396ac7a6dce724d04ac7b3bcef1db1d551:
> 
>    Merge branch 'robot/pr-0-1700068965' into 'main' (2023-11-15 17:24:46 +0000)
> 
> are available in the Git repository at:
> 
>    http://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/linux-firmware.git tags/iwlwifi-fw-2023-11-16-fixed
> 
> for you to fetch changes up to f27dec616e29e44cd90645926c1459639d112c3d:
> 
>    iwlwifi: fix for the new FWs from core83-55 release (2023-11-16 12:15:53 +0200)
> 
> ----------------------------------------------------------------
> Fixed firmware and PNVM signatures
> 
> ----------------------------------------------------------------
> Gregory Greenman (1):
>        iwlwifi: fix for the new FWs from core83-55 release
> 
>   iwlwifi-gl-c0-fm-c0-86.ucode  | Bin 1840116 -> 1840116 bytes
>   iwlwifi-gl-c0-fm-c0.pnvm      | Bin 226668 -> 226668 bytes
>   iwlwifi-ma-b0-gf-a0-86.ucode  | Bin 1695788 -> 1695788 bytes
>   iwlwifi-ma-b0-gf-a0.pnvm      | Bin 55092 -> 55092 bytes
>   iwlwifi-ma-b0-gf4-a0-86.ucode | Bin 1670940 -> 1670940 bytes
>   iwlwifi-ma-b0-gf4-a0.pnvm     | Bin 27820 -> 27820 bytes
>   iwlwifi-ma-b0-hr-b0-86.ucode  | Bin 1520636 -> 1520636 bytes
>   iwlwifi-so-a0-gf-a0-86.ucode  | Bin 1679788 -> 1679788 bytes
>   iwlwifi-so-a0-gf-a0.pnvm      | Bin 55172 -> 55172 bytes
>   iwlwifi-so-a0-gf4-a0-86.ucode | Bin 1653836 -> 1653836 bytes
>   iwlwifi-so-a0-gf4-a0.pnvm     | Bin 27860 -> 27860 bytes
>   iwlwifi-so-a0-hr-b0-86.ucode  | Bin 1507388 -> 1507388 bytes
>   iwlwifi-ty-a0-gf-a0-86.ucode  | Bin 1632464 -> 1632464 bytes
>   iwlwifi-ty-a0-gf-a0.pnvm      | Bin 55020 -> 55020 bytes
>   14 files changed, 0 insertions(+), 0 deletions(-)

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


