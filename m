Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27DE224D80A
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Aug 2020 17:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbgHUPJF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Aug 2020 11:09:05 -0400
Received: from mail.as201155.net ([185.84.6.188]:44857 "EHLO mail.as201155.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727116AbgHUPJF (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Aug 2020 11:09:05 -0400
Received: from smtps.newmedia-net.de ([2a05:a1c0:0:de::167]:59298 helo=webmail.newmedia-net.de)
        by mail.as201155.net with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <s.gottschall@dd-wrt.com>)
        id 1k98f7-0007SY-2x; Fri, 21 Aug 2020 17:09:02 +0200
X-CTCH-RefID: str=0001.0A782F1C.5F3FE38E.0006,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=dd-wrt.com; s=mikd;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=7a0p5GUpUp296wFP8sTlq5NnMObdEmvG2XKEgK9OIq4=;
        b=XtK9su0c5ZkWPifgy27M8y8aP0AngBTiF3/vFjCd+rLbZ0Q0R5EHZa9AxNliHPseXFlELiWLhd8oLpm5UitXuARE7PovZcoicQzdzZUsTo5CmLxen8vkmSlFPufF+SuSeN1K5IXoLj4lWazSyTtVTInln2wC1BLqloDcuO+EhjE=;
Subject: Re: [PATCH 5.9 3/3] mac80211: improve AQL aggregation estimation for
 low data rates
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@redhat.com>,
        Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
References: <20200813155212.97884-1-nbd@nbd.name>
 <20200813155212.97884-3-nbd@nbd.name>
 <c3c5197f-17f7-4f6b-712f-d7c68f39ae38@dd-wrt.com> <87tuww2ggm.fsf@toke.dk>
From:   Sebastian Gottschall <s.gottschall@dd-wrt.com>
Message-ID: <61d66ec8-117e-7c75-2b4a-1de7715f0bce@dd-wrt.com>
Date:   Fri, 21 Aug 2020 17:09:00 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <87tuww2ggm.fsf@toke.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Received:  from [2a01:7700:8040:300:5c7:f892:c89c:63d8]
        by webmail.newmedia-net.de with esmtpsa (TLSv1:AES128-SHA:128)
        (Exim 4.72)
        (envelope-from <s.gottschall@dd-wrt.com>)
        id 1k98f7-000KOu-Gq; Fri, 21 Aug 2020 17:09:01 +0200
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

i mean airtime fairness policy was not configured

Am 21.08.2020 um 16:58 schrieb Toke Høiland-Jørgensen:
> Sebastian Gottschall <s.gottschall@dd-wrt.com> writes:
>
>> in my tests the patch series decreases the performance of ath10k
>> chipsets by 50%, even if feature is not enabled.
> "even if feature is not enabled" - you mean without the AQL feature bit
> set in the driver? That makes no sense...
>
> -Toke
>
>
