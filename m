Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E241D265CB2
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Sep 2020 11:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725789AbgIKJnq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Sep 2020 05:43:46 -0400
Received: from pop36.abv.bg ([194.153.145.227]:52424 "EHLO pop36.abv.bg"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbgIKJnk (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Sep 2020 05:43:40 -0400
X-Greylist: delayed 388 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 Sep 2020 05:43:39 EDT
Received: from smtp.abv.bg (localhost [127.0.0.1])
        by pop36.abv.bg (Postfix) with ESMTP id BC7AA1805C62
        for <linux-wireless@vger.kernel.org>; Fri, 11 Sep 2020 12:37:06 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=abv.bg; s=smtp-out;
        t=1599817026; bh=XgQyOCFPANTgT8Fj/KI4kde7ooaeTXQ3GxNklv7xecY=;
        h=To:From:Subject:Date:From;
        b=p3gPB2/s5+mbi6VQfMF+3vjHECu4OxPxZHW4rNmdMBNlvY4RjFSS8XfdmxJvNPfZN
         yTR62vGnLaYB4/3zwcPF1vaK+A3ho8MaZJpzctMKd+oGMsPvs2AP8nLtWTInuUtmA4
         2t9GVq11EZIzZA/3l6z3U+/dhLB5x/4CIf0pXbyA=
X-HELO: [192.168.1.110]
Authentication-Results: smtp.abv.bg; auth=pass (plain) smtp.auth=buboleck@abv.bg
Received: from 46-249-79-198.net1.bg (HELO [192.168.1.110]) (46.249.79.198)
 by smtp.abv.bg (qpsmtpd/0.96) with ESMTPSA (ECDHE-RSA-AES256-GCM-SHA384 encrypted); Fri, 11 Sep 2020 12:37:06 +0300
To:     linux-wireless@vger.kernel.org
From:   Dimitar Kosev <buboleck@abv.bg>
Subject: RTW88 does not support rtl8821ce RFE4 cards
Message-ID: <73964f6f-bf86-4cfa-91ef-0ff03caa5f86@abv.bg>
Date:   Fri, 11 Sep 2020 12:37:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

My rtl8821ce card is RFE4 and I see the driver only supports RFE 0 and 1:

[ 2.324824] rtw_8821ce 0000:01:00.0: enabling device (0000 -> 0003)
[ 2.329142] rtw_8821ce 0000:01:00.0: Firmware version 24.5.0, H2C version 12
[ 2.350506] rtw_8821ce 0000:01:00.0: rfe 4 isn't supported
[ 2.350612] rtw_8821ce 0000:01:00.0: failed to setup chip efuse info
[ 2.350615] rtw_8821ce 0000:01:00.0: failed to setup chip information

Kind regards.

