Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7745B1BECED
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2020 02:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgD3ATU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Apr 2020 20:19:20 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:52568 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726279AbgD3ATT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Apr 2020 20:19:19 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588205959; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=EIWufjFryBx0mC1G7IJ3e7cfLptIo4Cwz24m5wcCncE=;
 b=k1wNdhmRlMEC+J7Psc385y8VLEHXw9fQF6SVGXj1D4yfK/TFuug9suQKixCF2VLzuOOx3/k5
 p5r2FvF/kPxgOtYxE3UYVdZvyN86dXeCRNcDZNZ+aZo5Gt+QO4xFSjFvCoWK9KyAsZ5Hwe6Y
 XplGUWTbAaMwbciL0/3d/NBNpsY=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eaa196e.7f721d539030-smtp-out-n03;
 Thu, 30 Apr 2020 00:18:54 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1C505C433BA; Thu, 30 Apr 2020 00:18:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: rmanohar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7D8BFC432C2;
        Thu, 30 Apr 2020 00:18:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 29 Apr 2020 17:18:51 -0700
From:   Rajkumar Manoharan <rmanohar@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH 09/10] mac80211: determine chantype from HE operation in 6
 GHz
In-Reply-To: <3b2b90685e55d3eae22171cf46340af5154bb59f.camel@sipsolutions.net>
References: <1587768108-25248-1-git-send-email-rmanohar@codeaurora.org>
 <1587768108-25248-10-git-send-email-rmanohar@codeaurora.org>
 <3b2b90685e55d3eae22171cf46340af5154bb59f.camel@sipsolutions.net>
Message-ID: <a5d931f074cbce8073abd8257555d3bb@codeaurora.org>
X-Sender: rmanohar@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-04-29 07:34, Johannes Berg wrote:
> On Fri, 2020-04-24 at 15:41 -0700, Rajkumar Manoharan wrote:
>> In 6 GHz band, determine chandef from 6 GHz operation information
>> of HE operation element.
> 
> Yeah... I had this too. Oh well.
> 
Thanks for feedback. Have few more changes on top this series.
Before posting next version, would prefer to bundle with your changes. 
thoughts?

-Rajkumar
