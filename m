Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BEC124F1F7
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Aug 2020 06:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbgHXEg6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Aug 2020 00:36:58 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:13312 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726684AbgHXEg6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Aug 2020 00:36:58 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598243817; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=0sZxxuMxYlGa641HdQUl0QKGYAfnef6tBOWHc7owg/g=;
 b=q9sGVlHYe2Y0Ysn8IZJLJEiLgID6xEihfepueoCFA9M1NJBa7ZGnSbJW1RmHuujzO5mwQRdc
 B0TdejcGHOzD0ZL4pxaVX1KSFjLA9VwFNvxtG8vHGjHxe0nFdzDwP/+CjLTc6qb3qQcJf3UK
 Taectaa6mffrsOHmrols6G5IFPA=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5f4343e41207480ea95b1f56 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 24 Aug 2020 04:36:52
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3D672C433CB; Mon, 24 Aug 2020 04:36:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E51DFC433CA;
        Mon, 24 Aug 2020 04:36:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 24 Aug 2020 12:36:51 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v4 1/2] ath10k: add refcount for ath10k_core_restart
In-Reply-To: <725b4377f63c76627e1e68604323cb74@codeaurora.org>
References: <20200108031957.22308-1-wgong@codeaurora.org>
 <20200108031957.22308-2-wgong@codeaurora.org>
 <87imdlkuw8.fsf@codeaurora.org>
 <725b4377f63c76627e1e68604323cb74@codeaurora.org>
Message-ID: <41a24ff4694edca225e1c062184e8742@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-08-20 17:18, Wen Gong wrote:
...
> I thinks we can use test_and_set_bit for atomic operation athough it
> is same with restart_count.
> and add a new flag, ATH10K_FLAG_CRASH_FLUSH is used for flush,
> if still use ATH10K_FLAG_CRASH_FLUSH, it should change clear_bit of it 
> from
> ath10k_core_start to ath10k_reconfig_complete,because
> ieee80211_reconfig(called by
> ieee80211_restart_work)
> of mac80211 do many things and drv_start is 1st thing and
> drv_reconfig_complete is last thing, drv_reconfig_complete done means
> the restart
> finished.
> 
> I will send patch v5 with above changes if not other advise.
v5 sent: https://patchwork.kernel.org/patch/11728101/
...
