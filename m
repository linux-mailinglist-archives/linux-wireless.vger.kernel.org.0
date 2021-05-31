Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B93739541F
	for <lists+linux-wireless@lfdr.de>; Mon, 31 May 2021 05:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbhEaDGo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 30 May 2021 23:06:44 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:37249 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbhEaDGm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 30 May 2021 23:06:42 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1622430303; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=Or/D49BJIOEB6eLFPLwThrUBfwDf6Y7sHmq8eM+/Z7Q=;
 b=Q9SArqlY34WIxzTquLCamoCnwn5vni4+noW+QCcUJzFSwvnZPJSUvIkriZppJS+5hD97n7zZ
 vCDnVkuWluABNrRi+ZT+Guwim/K/7hGYuPFgOPUH6m8A9xvUZpAx1wcma8yNxubNsp3c3pL/
 b63c7NtuoYyRZ6+eFVxe8vmnSWo=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 60b452448491191eb39cd2cd (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 31 May 2021 03:04:36
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4D252C43217; Mon, 31 May 2021 03:04:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4305BC433D3;
        Mon, 31 May 2021 03:04:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 31 May 2021 11:04:33 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     kernel test robot <lkp@intel.com>
Cc:     johannes@sipsolutions.net, ath11k@lists.infradead.org,
        kbuild-all@lists.01.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2] wireless: add check of field VHT Extended NSS BW
 Capable for 160/80+80 MHz setting
In-Reply-To: <202105230249.n4ifN4Wm-lkp@intel.com>
References: <20210521021809.23986-1-wgong@codeaurora.org>
 <202105230249.n4ifN4Wm-lkp@intel.com>
Message-ID: <6dedc959bd3b7515a7e151ea4dae2964@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-05-23 02:36, kernel test robot wrote:
> Hi Wen,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on mac80211-next/master]
> [also build test WARNING on mac80211/master v5.13-rc2 next-20210521]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:
> https://github.com/0day-ci/linux/commits/Wen-Gong/wireless-add-check-of-field-VHT-Extended-NSS-BW-Capable-for-160-80-80-MHz-setting/20210522-224810
> base:
> https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211-next.git
> master
> config: i386-randconfig-s001-20210522 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> reproduce:
>         # apt-get install sparse
>         # sparse version: v0.6.3-341-g8af24329-dirty
>         #
> https://github.com/0day-ci/linux/commit/ed41c78effa1b66bb3d00e368b92940e5ffadb57
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review
> Wen-Gong/wireless-add-check-of-field-VHT-Extended-NSS-BW-Capable-for-160-80-80-MHz-setting/20210522-224810
>         git checkout ed41c78effa1b66bb3d00e368b92940e5ffadb57
>         # save the attached .config to linux build tree
>         make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' W=1 
> ARCH=i386
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> 
> sparse warnings: (new ones prefixed by >>)
>>> net/wireless/chan.c:953:39: sparse: sparse: restricted __le16 
>>> degrades to integer
> 

please use new patch: "[PATCH v3] wireless: add check of field VHT 
Extended NSS BW Capable for 160/80+80 MHz setting"

...
