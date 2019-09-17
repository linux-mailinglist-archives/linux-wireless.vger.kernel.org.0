Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A34ABB55F0
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Sep 2019 21:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729837AbfIQTHW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Sep 2019 15:07:22 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:42899 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbfIQTHW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Sep 2019 15:07:22 -0400
Received: from marcel-macbook.fritz.box (p4FEFC197.dip0.t-ipconnect.de [79.239.193.151])
        by mail.holtmann.org (Postfix) with ESMTPSA id 64923CECC3;
        Tue, 17 Sep 2019 21:16:11 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [RFC 0/4] Allow live MAC address change
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190917204419.41235404@smicro.local.lan>
Date:   Tue, 17 Sep 2019 21:05:51 +0200
Cc:     linux-wireless@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <CD7F7105-C701-42AE-BCB5-4E413B416071@holtmann.org>
References: <20190904191155.28056-1-prestwoj@gmail.com>
 <d776271eac8b7cd24da6dbd21fb87186b30a0e7f.camel@sipsolutions.net>
 <4c43ea6a74cacc61184bc5b1387fecaa40711369.camel@gmail.com>
 <4909a428ee6fef2bf8b0e61841bc88062f534b13.camel@sipsolutions.net>
 <896183390a396e8e0508622eceb3664effcb3c30.camel@gmail.com>
 <87a7b8lciz.fsf@tynnyri.adurom.net>
 <844f1a1dc72ec73df5a86864b410bbc490c4abdd.camel@gmail.com>
 <87imprbc0j.fsf@kamboji.qca.qualcomm.com>
 <763f4560-ba78-b0e7-6855-fd4bc048ec13@gmail.com>
 <20190917204419.41235404@smicro.local.lan>
To:     Bob Marcan <bob.marcan@gmail.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Bob,

>>> For user experience scanning and DHCP are also important, what kind of > numbers you get when those are included? No need to have anything> precise, I would like just to get an understanding where we are> nowadays.  
>> 
>> Scanning heavily depends on the RF environment and the hardware.  In our testing ath9k takes stupid long to scan for example.
>> 
>> But in a sort of best case scenario, using limited scan and no mac change, iwd connects in ~300ms.  People have reported that they have not finished opening their laptop screen and they're connected, so at that level of latency, every millisecond is important and totally worth fighting for.  Randomizing the MAC would penalize our connection times by 2X (300 ms at least).  And Android folks have reported the penalty to be as high as 3 seconds.  So this needs to be fixed.  And do note that this is a feature every modern OS implements by default.
> 
> Randomizing the MAC is a stupid decision.
> Do you realy expect that this will add something to the security?

the mac randomization is about privacy.

Regards

Marcel

