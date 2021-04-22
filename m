Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD0D36869F
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Apr 2021 20:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236752AbhDVShG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Apr 2021 14:37:06 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:34333 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236665AbhDVShF (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Apr 2021 14:37:05 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1619116590; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=OxBmPnHU9ndejkgZ+VQYCgISY9oqMAK9CWEIyatUw9U=;
 b=rdsaTgbcl2CTSKZABNoeKLgDVHgpLLdVJTHuiMbmjiMiAJz2z1UIGAbATVj8DKYVCWZMWIda
 IKM0ivMlyrUgMOVLWWHdAdccwnm/7OJX3Z7rxUqSPIybQ92zMIjz/yuFjRy1XTi80LM8ANBJ
 J6OMzfZJRXMbN/LIqTR1dfDMcTw=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 6081c229c39407c327a3d73e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 22 Apr 2021 18:36:25
 GMT
Sender: pradeepc=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DCCABC433D3; Thu, 22 Apr 2021 18:36:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: pradeepc)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A52C9C433F1;
        Thu, 22 Apr 2021 18:36:24 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 22 Apr 2021 11:36:24 -0700
From:   Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
To:     ath11k@lists.infradead.org, Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, Miles Hu <milehu@codeaurora.org>,
        Anilkumar Kolli <akolli@codeaurora.org>
Subject: Re: [PATCH v9 3/3] ath11k: translate HE status to radiotap format
In-Reply-To: <20210404125235.5589-4-pradeepc@codeaurora.org>
References: <20210404125235.5589-1-pradeepc@codeaurora.org>
 <20210404125235.5589-4-pradeepc@codeaurora.org>
Message-ID: <191c8590492d39dee3d241576e30b642@codeaurora.org>
X-Sender: pradeepc@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi kalle,

I see the status of the series V9 in Deferred state.
As I don't see any comments in the patchwork,
just wanted to confirm if anything is expected from
me?

Thanks
Pradeep
