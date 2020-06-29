Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA48D20CBA9
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jun 2020 04:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbgF2CIw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 28 Jun 2020 22:08:52 -0400
Received: from mon2.sibername.com ([162.144.51.228]:40946 "EHLO
        mon1.sibername.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726071AbgF2CIv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 28 Jun 2020 22:08:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lockie.ca;
         s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version
        :Date:Message-ID:References:Cc:To:Subject:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=fQSTTzDUfOSdaFS3ops75oLYY08rFBZInRffBNVUFj8=; b=ly6Ouy8gLsS1qh8TY1OPQKTMe1
        eSrFttlaK/78iDjVtv1yXS5H6CTWzFxQsBtZhtCnblLI1wZX17qZo+2Eq6jMcr6vXDzTsVsSE7KVi
        3w5VFHUc7UHiKEXFrkkPBAJoU0qjv0u7vZnmtNy1d6GQpKgptsxHwxPmBA5dYOV7G5+DHK/oGUkJ2
        e3V4j3OSUA5V5kdK2kfjk6bqamHU470ymXiQLEssV7NoqCmuS2pP3fEcc7p9Lr7y7Z8+Gfdzmuw8Y
        IsnHTOjPOdEDi9qptpD7JBhRhmTVnvr50ImLQqtOjoHw1jFXPH0LTNfsD6dj815ENURjvvAwvi98w
        a39DVvzw==;
Received: from 216-58-17-101.cpe.distributel.net ([216.58.17.101]:32894 helo=[192.168.1.4])
        by montreal.sibername.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <bjlockie@lockie.ca>)
        id 1jpjDg-003jpC-6P; Sun, 28 Jun 2020 22:08:29 -0400
From:   James <bjlockie@lockie.ca>
Subject: Re: Alfa AWUS036ACM (Mediatek MT7612U) AP problem
To:     Mathy Vanhoef <vanhoefm@gmail.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
References: <ba64416e-d34b-9bdd-d482-6ea722e3d6b9@lockie.ca>
 <CAFXAJYwgRPAbY4i8XHNGzcyJg-11BwOSdDS6098eh_CEzxeEUQ@mail.gmail.com>
Message-ID: <9c44f87b-eaa5-afcb-b830-30b2b36232d5@lockie.ca>
Date:   Sun, 28 Jun 2020 22:08:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAFXAJYwgRPAbY4i8XHNGzcyJg-11BwOSdDS6098eh_CEzxeEUQ@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - montreal.sibername.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lockie.ca
X-Get-Message-Sender-Via: montreal.sibername.com: authenticated_id: rjl@lockie.ca
X-Authenticated-Sender: montreal.sibername.com: rjl@lockie.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kernel 5.4.48 is better so far:
Uptime
1d 18h 6m 32s
It sounds like it is only a matter of time since you have the problem on 
a later kernel.
I did get rid of a cable and use a powered USB 3 hub.
