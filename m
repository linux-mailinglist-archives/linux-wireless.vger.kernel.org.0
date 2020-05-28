Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 299711E57FD
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2020 08:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgE1G5T (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 02:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgE1G5T (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 02:57:19 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D86FC05BD1E
        for <linux-wireless@vger.kernel.org>; Wed, 27 May 2020 23:57:19 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jeCTd-004hIk-OL; Thu, 28 May 2020 08:57:17 +0200
Message-ID: <7ecbd284ff0c0f439034e003a450083c645361fb.camel@sipsolutions.net>
Subject: Re: Auth/Assoc/Connect events coming before CMD_CONNECT response
 (hwsim)
From:   Johannes Berg <johannes@sipsolutions.net>
To:     James Prestwood <prestwoj@gmail.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 28 May 2020 08:57:16 +0200
In-Reply-To: <967e9193bc7d6573c4f0226e5801f2aeed92dc1c.camel@gmail.com> (sfid-20200528_010312_023822_A43149DE)
References: <CAPv5Ue7kNRRf9esOKkQ=Kkx8f0_vdkiPYg24pzVsv3Dg71Ow_Q@mail.gmail.com>
         <259da597c3902c79c9d5c6e171e109dcb68564eb.camel@sipsolutions.net>
         <CAPv5Ue4Cp=Eeo+xy1K0CRz-AC3p-tUnEuRjuL1dyt0yiKhpwpA@mail.gmail.com>
         (sfid-20200501_193303_702944_53D89397) <68be99836859c4216a667e5784ed0e519cc1143c.camel@sipsolutions.net>
         <967e9193bc7d6573c4f0226e5801f2aeed92dc1c.camel@gmail.com>
         (sfid-20200528_010312_023822_A43149DE)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi James,

> I was actually incorrect thinking we used wmediumd, we don't :) We have
> our own hwsim thing that is effectively taking the place of wmediumd.

Oh. But my theory was that even purely the roundtrip out to userspace
and back would make the issue go away, so I guess I was still wrong.

> And with this I added a very small delay to resending out the frames
> and it totally fixed the issue.

I guess that's more realistic anyway :)

johannes

