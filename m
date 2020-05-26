Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9F81E2207
	for <lists+linux-wireless@lfdr.de>; Tue, 26 May 2020 14:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389012AbgEZMid (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 May 2020 08:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388497AbgEZMid (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 May 2020 08:38:33 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00702C03E96D
        for <linux-wireless@vger.kernel.org>; Tue, 26 May 2020 05:38:32 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jdYql-003QFU-A4; Tue, 26 May 2020 14:38:31 +0200
Message-ID: <68be99836859c4216a667e5784ed0e519cc1143c.camel@sipsolutions.net>
Subject: Re: Auth/Assoc/Connect events coming before CMD_CONNECT response
 (hwsim)
From:   Johannes Berg <johannes@sipsolutions.net>
To:     James Prestwood <prestwoj@gmail.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Tue, 26 May 2020 14:38:30 +0200
In-Reply-To: <CAPv5Ue4Cp=Eeo+xy1K0CRz-AC3p-tUnEuRjuL1dyt0yiKhpwpA@mail.gmail.com> (sfid-20200501_193303_702944_53D89397)
References: <CAPv5Ue7kNRRf9esOKkQ=Kkx8f0_vdkiPYg24pzVsv3Dg71Ow_Q@mail.gmail.com>
         <259da597c3902c79c9d5c6e171e109dcb68564eb.camel@sipsolutions.net>
         <CAPv5Ue4Cp=Eeo+xy1K0CRz-AC3p-tUnEuRjuL1dyt0yiKhpwpA@mail.gmail.com>
         (sfid-20200501_193303_702944_53D89397)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi James,

> > I guess you could "fix" that by running with wmediumd?
> 
> We do run with wmediumd, although I hadn't looking into this much.

Well, I was sort of assuming that even just running wmediumd would
introduce the latency of another userspace roundtrip, and, perhaps more
importantly, disconnect the code paths.

I didn't really think you need any additional delay, and yes, I don't
think wmediumd supports adding additional delay, but it does add its own
fake medium acquisition delay.

So maybe that means my theory was wrong?

johannes

