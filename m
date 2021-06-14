Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA523A6B73
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Jun 2021 18:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234579AbhFNQRz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Jun 2021 12:17:55 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:22036 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234013AbhFNQRy (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Jun 2021 12:17:54 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1623687351; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=AlewFTlzAf0o7ZgV/18bVpDMgPCIxAnBGmtk8MujTRg=;
 b=uu0kpDwlaeE/VNOMNtDMOQH2uTP64uWFHs7w2ZiBWtRBxOc01cL3sxYNqn4hpPUYn/+L95Ud
 ZDKh7Ih0Eq+rRFUDa1ooluUVrO1+B0O7eLzi2aRwkGtXVQnYw0yMAV/YSBqveKKWO3MQ0j8r
 bZVhP8jUEChzo8Qvivat4069m2g=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 60c78094f726fa4188af057f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 14 Jun 2021 16:15:16
 GMT
Sender: alokad=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 40CC1C43143; Mon, 14 Jun 2021 16:15:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: alokad)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6F343C43460;
        Mon, 14 Jun 2021 16:15:13 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 14 Jun 2021 09:15:13 -0700
From:   Aloka Dixit <alokad@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, John Crispin <john@phrozen.org>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        alokad=codeaurora.org@codeaurora.org
Subject: Re: [PATCH v10 1/4] nl80211: multiple bssid and EMA support in AP
 mode
In-Reply-To: <20210426190534.12667-2-alokad@codeaurora.org>
References: <20210426190534.12667-1-alokad@codeaurora.org>
 <20210426190534.12667-2-alokad@codeaurora.org>
Message-ID: <78a2a3cf3f484934c57b06dfe4e1592c@codeaurora.org>
X-Sender: alokad@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-04-26 12:05, Aloka Dixit wrote:
> From: John Crispin <john@phrozen.org>
> 
> This commit adds new attributes to configure support for multiple BSSID
> and advanced multi-BSSID advertisements (EMA) in AP mode.
> 

Hi Johannes,
Please provide comments on this patch-set.
Thanks.
