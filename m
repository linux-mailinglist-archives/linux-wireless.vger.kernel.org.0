Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5998AC2E49
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2019 09:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733080AbfJAHkA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Oct 2019 03:40:00 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:56050 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731358AbfJAHkA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Oct 2019 03:40:00 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iFClL-00014u-GN; Tue, 01 Oct 2019 09:39:59 +0200
Message-ID: <df3b53f157e113e309360ed40b1f36b9f08f4d8c.camel@sipsolutions.net>
Subject: Re: mac80211_hwsim (kernel 4.18+): wmediumd + 2.4Ghz
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ramon Fontes <ramonreisfontes@gmail.com>,
        Krishna Chaitanya <chaitanya.mgit@gmail.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Date:   Tue, 01 Oct 2019 09:39:58 +0200
In-Reply-To: <CAK8U23bb9C+16zuGi+uAYxUg-goddiSZfDAJUYeC1Xpu=jud+Q@mail.gmail.com> (sfid-20190930_202838_727383_A4E81EAE)
References: <CAK8U23biuUY9hWE1NOnSbJCRtRVfdg1a27ZOkU5cbaGdzZLYEA@mail.gmail.com>
         <fa029365caf3db963b1c2ec05ae389a8c8fc20fb.camel@sipsolutions.net>
         <CAK8U23aHprXtZm2PV3sj6g4Da_ponK9L0YmSO1tb6xoFgK-ZLA@mail.gmail.com>
         <80d9c12986ec0a13c34672ca1c16f37cae0cc096.camel@sipsolutions.net>
         <CABPxzYLrTC3kS86iyfq+RY=XEgjedu2MWPtn+i+H50jPz3oh3w@mail.gmail.com>
         <39d646206446159a2b0a67ee7d8667483ade0733.camel@sipsolutions.net>
         <CABPxzYL0i+YbKh-xMXsS-xWeQvwfFUvv7vGhugM1e+OFMOSHSg@mail.gmail.com>
         <CAK8U23bbiGhmDg-ChDJtbRVVc_6njVdoUjfAhqM+V3yfQXTC4Q@mail.gmail.com>
         <CABPxzY+8Jjvjv0x79yzo+rL3nONTZSkROK1T+gMqq5nhXb=7-g@mail.gmail.com>
         <CAK8U23bb9C+16zuGi+uAYxUg-goddiSZfDAJUYeC1Xpu=jud+Q@mail.gmail.com>
         (sfid-20190930_202838_727383_A4E81EAE)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2019-09-30 at 15:28 -0300, Ramon Fontes wrote:
> > Based on this info, looks like hostapd/wpa_s versions might be causing
> > the difference,
> > can you please confirm the versions on both?
> 
> They have the same hostap (hostapd + wpa_s) version:
> Hostapd v2.10-devel-hostap_2_9-102-g12de14907+
> wpa_supplicant v2.10-devel-hostap_2_9-102-g12de14907+

Do they also have the same version of wmediumd?

> I've tested with v2.8-devel-hostap_2_7-313-g3e949655c+ too.
> 
> In this short video (https://www.youtube.com/watch?v=f6rrHIGpePA -
> running on VirtualBox) you can see the problem in action. Through this
> video you can see that it works with 4.16 and 4.17, and doesn't work
> with 4.19 (I forgot to repeat the test with 4.18, but I confirm that
> it has the same behaviour as 4.19).

Regardless, we should fix this stuff ...

johannes

