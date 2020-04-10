Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA1821A427B
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2020 08:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbgDJGVQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Apr 2020 02:21:16 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:43660 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725839AbgDJGVP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Apr 2020 02:21:15 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586499675; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=6gn2EZYGQjodcr4M8bz1Jx0pei/MET0dh1dphfH9Cp0=;
 b=nshD1C5TUGNL7JVP7V2YKCJxGzrkE6LNllxW4XJZevLXqh1v7K7/QQ6a2qYO/5/ZoxsvkjKr
 VKy+2ZxtILhP04ReIi7h121rPPW2Pqyc2OouSyYsT7QGE2TMZgZqIZbdN6h63HfziuYfca8a
 H/eowyjz8bQtTEK+qrGAo3M0tS8=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e90104e.7f780b39a880-smtp-out-n01;
 Fri, 10 Apr 2020 06:21:02 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CA2A2C433D2; Fri, 10 Apr 2020 06:21:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED autolearn=ham
        autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A0FB9C433CB;
        Fri, 10 Apr 2020 06:21:02 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 10 Apr 2020 14:21:02 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH v9 0/4] ath10k: improve throughout of TX of sdio
In-Reply-To: <20200212080415.31265-1-wgong@codeaurora.org>
References: <20200212080415.31265-1-wgong@codeaurora.org>
Message-ID: <54bfdf4093153ec1838881a0cf96c30f@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-02-12 16:04, Wen Gong wrote:

v10 sent
https://patchwork.kernel.org/cover/11482763/
