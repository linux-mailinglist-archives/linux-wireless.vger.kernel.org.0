Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A42A5FDBA
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jul 2019 22:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfGDUUR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 Jul 2019 16:20:17 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:40856 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbfGDUUR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 Jul 2019 16:20:17 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hj8DG-0007hB-5o; Thu, 04 Jul 2019 22:20:14 +0200
Message-ID: <b120890b4b784036a139b0d676032bae263a0642.camel@sipsolutions.net>
Subject: Re: [Linux-kernel-mentees][PATCH v2] nl80211: Fix undefined
 behavior in bit shift
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jiunn Chang <c0d1n61at3@gmail.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 04 Jul 2019 22:20:11 +0200
In-Reply-To: <20190704183432.av37fjd5s3zcho6m@rYz3n> (sfid-20190704_203436_301195_44BD720F)
References: <20190627010137.5612-4-c0d1n61at3@gmail.com>
         <20190627032532.18374-4-c0d1n61at3@gmail.com>
         <c20a0a94-ab50-bb85-7c78-e02a465c5a40@linuxfoundation.org>
         <8b8c44c3ecb8626d9bb5a8f786b1d2b7488df86b.camel@sipsolutions.net>
         <20190704183432.av37fjd5s3zcho6m@rYz3n>
         (sfid-20190704_203436_301195_44BD720F)
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2019-07-04 at 13:34 -0500, Jiunn Chang wrote:
> Would you like me to send v3 with the change log in the patch description?
> 
No no, like I said, it's not very useful in this case anyway.

johannes

