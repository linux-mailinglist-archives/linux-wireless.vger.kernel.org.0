Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 897551D2B0A
	for <lists+linux-wireless@lfdr.de>; Thu, 14 May 2020 11:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgENJNU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 May 2020 05:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725935AbgENJNU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 May 2020 05:13:20 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA09DC061A0C;
        Thu, 14 May 2020 02:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=skogtun.org
        ; s=ds201912; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=KDx+FlTyn73Rfh8BtAIM8TPjZDA+d19GZ+//31gul5Q=; b=EEuQ+q9xcrqkTTt6mSAiraCok3
        RfFJxZmNILOU0mBOEOhJNcCZkvFQ7K8sDaI/fJPZFA5vd1dy5cjyd7eQAEySc2c1WLXSZ8naKvOzi
        6CKwwFz+FAltIyejm+jPYqJbKpf5mJs2LxZuwF30+j4MY0XUSGyFokFkKSGctf4Bug/B07kfW4Npb
        OMmawrtHarbf4zFhBuNDF9h+zcSZLJA00i58RBkCrZrjhEAsSTC+kvzCeSFFlMZdaM5gcYH5pbvxL
        5U8xLYJAws22X8rKFumnGYHmIzWzMJxhOTZSG8PG0hh1SBokJ0Nqy888RgCGBm+M9Fb/QldiUGrSQ
        Gk9r6CgQ==;
Received: from [2a01:79c:cebf:7fb0:d967:6cf9:736f:4613] (port=44740)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <harald@skogtun.org>)
        id 1jZ9vX-0002gK-KQ; Thu, 14 May 2020 11:13:15 +0200
Subject: Re: gcc-10: kernel stack is corrupted and fails to boot
To:     Kalle Valo <kvalo@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20200509120707.188595-1-arnd@arndb.de>
 <20200509120707.188595-2-arnd@arndb.de>
 <87v9l24qz6.fsf@kamboji.qca.qualcomm.com>
 <87r1vq4qev.fsf@kamboji.qca.qualcomm.com>
 <87d078tjl0.fsf_-_@kamboji.qca.qualcomm.com>
 <CAK8P3a1dxJAHCZ19=sPUkDi5wLWeJ6KKtD09Wmjqkz27TQN6Xw@mail.gmail.com>
 <87zhacrokl.fsf@kamboji.qca.qualcomm.com>
 <CAK8P3a1mMcpVE5kLv-krjL_ZjqfRXDK4e3fChzuom_QFRtTJqw@mail.gmail.com>
 <87v9kzsvg8.fsf@kamboji.qca.qualcomm.com>
From:   Harald Arnesen <harald@skogtun.org>
Message-ID: <443d4178-f22e-81dd-36ea-d3c7b4b0c933@skogtun.org>
Date:   Thu, 14 May 2020 11:13:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <87v9kzsvg8.fsf@kamboji.qca.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo [13.05.2020 17:31]:

> Great, so it's not a problem due to my setup.

I see the same thing on two machines, using a self-compiled gcc 10.1.0.
Glad to hear it's not just me. Switched back to 9.3.0 for the time being.
-- 
Hilsen Harald
