Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD7621C5B1
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2019 11:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbfENJKe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 May 2019 05:10:34 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44820 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfENJKe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 May 2019 05:10:34 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 38C3860DB3; Tue, 14 May 2019 09:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557825033;
        bh=uDnoGLYB9Xd9RBWabADon1gLoTcqeYJXItpqtC7+A0E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZrMOef0vdNAehkvcQLxi/sia1acmYRKIXJ7z4VVMdeXCkR7A7GnzIMTr9r0VA8ABH
         d3ZJDo+ilXsG9jjVWxe1HNTGa931x0Iee20ZpXOrSWotzbGeamMLKJsJplsM1inr17
         M8Tre2sAL6qUP0/eimaPCh84TXeF7zLbe0um93II=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 79A4B60D35;
        Tue, 14 May 2019 09:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1557825029;
        bh=uDnoGLYB9Xd9RBWabADon1gLoTcqeYJXItpqtC7+A0E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PIL/DcdwM/d/ky2IAVhjrziKwuPO/PIH6JQZXuZlORv73RnmdyKBmokuHe+xYDhbg
         ncR/WpKE2rk2dPx8p6tp73+KMDx0svN6r6sq+GLQviDTTUyG92BxSQA1NtuYc9375/
         elWwOBVX3u7n2tsNwDN5Kj6XUZsJzNxxKP2WhJHg=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 14 May 2019 17:10:29 +0800
From:   Yibo Zhao <yiboz@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        Zhi Chen <zhichen@codeaurora.org>
Subject: Re: [PATCH v2] mac80211: remove warning message
In-Reply-To: <7c92f5cf51eaec1d5449698d90f5b6c5ca6c2bea.camel@sipsolutions.net>
References: <1557824507-17668-1-git-send-email-yiboz@codeaurora.org>
 (sfid-20190514_110314_752671_7E53E9A2)
 <7c92f5cf51eaec1d5449698d90f5b6c5ca6c2bea.camel@sipsolutions.net>
Message-ID: <ccb48284f0d96e72f4c041e12c943f0a@codeaurora.org>
X-Sender: yiboz@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-05-14 17:05, Johannes Berg wrote:
> On Tue, 2019-05-14 at 17:01 +0800, Yibo Zhao wrote:
>> In multiple SSID cases, it takes time to prepare every AP interface
>> to be ready in initializing phase. If a sta already knows everything 
>> it
>> needs to join one of the APs and sends authentication to the AP which
>> is not fully prepared at this point of time, AP's channel context
>> could be NULL. As a result, warning message occurs.
>> 
> Err, what was the point in sending v2 without any changes?
> 
> johannes
Hi Johannes,

I was planning to use WARN_ON_ONCE() in the first place to replace 
WARN_ON() then after some discussion, we think removing it could be 
better. So the first patch was based on my first version which is sent 
incorrectly. Please check again.

Sorry for the confusing.


-- 
Yibo
