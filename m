Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3CF51122B1
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Dec 2019 07:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbfLDGAD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Dec 2019 01:00:03 -0500
Received: from a27-21.smtp-out.us-west-2.amazonses.com ([54.240.27.21]:49362
        "EHLO a27-21.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725791AbfLDGAC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Dec 2019 01:00:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1575439202;
        h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID;
        bh=0o0a6TPT1s7PFwAcgXu8HHPTctk2Q0tP9BRyTRbd49k=;
        b=cwvgZJ0jQfiG9SPmTMeNQcPAyYXCuTVobOPRuOwlAvLtf6beWT4oCGtXS4YYoxB+
        KkTIc9UOHTjLgDlNry+0edDUmOvQwDOsR+8ibdcBtnsIE6UV+yXPkiG2+/nLphu2Dbn
        usZ1bPpVmzVjCKWFypOaY+SFZlWuS6CnHdU9Q4ls=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1575439202;
        h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:Feedback-ID;
        bh=0o0a6TPT1s7PFwAcgXu8HHPTctk2Q0tP9BRyTRbd49k=;
        b=f9hK/pokK/qKX8SqS8Je7uXBBxfO3/pw/yT/aXDrf1ZAf5pfiO/pRpZElBg8OALK
        aLV176szlscd4hXd10hiyAXf7o9swy8GBkfl9/9nM6fWUrwxa7TEbH+bjAzlrxloru3
        0Ih93wsL2gI/hSA6bVzgMXvXPS/hpcnap+mNSiTY=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 4 Dec 2019 06:00:01 +0000
From:   vthiagar@codeaurora.org
To:     John Crispin <john@phrozen.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, linux-wireless-owner@vger.kernel.org
Subject: Re: [RESEND 6/9] ath11k: add debugfs for TWT debug calls
In-Reply-To: <20191204053713.3064-7-john@phrozen.org>
References: <20191204053713.3064-1-john@phrozen.org>
 <20191204053713.3064-7-john@phrozen.org>
Message-ID: <0101016ecf7e75e8-c437f8fc-1c94-4c0d-8965-be3d32169ecf-000000@us-west-2.amazonses.com>
X-Sender: vthiagar@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
X-SES-Outgoing: 2019.12.04-54.240.27.21
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-12-04 11:07, John Crispin wrote:
> These new debugfs files allow us to manually add/del/pause/resume TWT
> dialogs for test/debug purposes.
> 

Information such as how these debugfs entries are supposed to be used
could be helpful.

Vasanth
