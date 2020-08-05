Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6500323C696
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Aug 2020 09:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbgHEHHx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Aug 2020 03:07:53 -0400
Received: from pop36.abv.bg ([194.153.145.227]:49098 "EHLO pop36.abv.bg"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725809AbgHEHHw (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Aug 2020 03:07:52 -0400
X-Greylist: delayed 424 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Aug 2020 03:07:51 EDT
Received: from smtp.abv.bg (localhost [127.0.0.1])
        by pop36.abv.bg (Postfix) with ESMTP id 473D81805D2F
        for <linux-wireless@vger.kernel.org>; Wed,  5 Aug 2020 10:00:43 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=abv.bg; s=smtp-out;
        t=1596610843; bh=xiEZ1jpcPsppSTk6p4UnoI2rRmPJ2NIlX1LqIeP+srQ=;
        h=To:From:Subject:Date:From;
        b=TzELviSz0YuCi2MXLYphJD6fKDh/A3KWI4v9rWrjwTsFtdEzmGo4/qqZB9wyL6uOf
         540y06RVOdwMdPKRX3sDIx8t1gin33HarXLZfPJaUhu9siWIHNbePAc0Ga43RdvuKU
         3XaQlR6xEWM00molw99aQs52zF0XyFR/0II+xoDY=
X-HELO: [192.168.1.110]
Authentication-Results: smtp.abv.bg; auth=pass (plain) smtp.auth=buboleck@abv.bg
Received: from 46-249-79-198.net1.bg (HELO [192.168.1.110]) (46.249.79.198)
 by smtp.abv.bg (qpsmtpd/0.96) with ESMTPSA (ECDHE-RSA-AES256-GCM-SHA384 encrypted); Wed, 05 Aug 2020 10:00:43 +0300
To:     linux-wireless@vger.kernel.org
From:   DImitar Kosev <buboleck@abv.bg>
Subject: RTW88 poor perception
Message-ID: <af8abf99-0cb0-ae18-e905-7bbf57270c82@abv.bg>
Date:   Wed, 5 Aug 2020 10:00:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

I have RTL8821CE card and with this driver I get poor perception on 5GHz 
(2-3 meters max to the router) and only 30-50cm to the router on 2.4GHz. 
I'm currently using this driver https://github.com/tomaspinho/rtl8821ce 
that works fine but I understand it will be deprecated once RTW88 goes 
into the kernel.

Kind regards.

