Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF04564DD85
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Dec 2022 16:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbiLOPOJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Dec 2022 10:14:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbiLOPNb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Dec 2022 10:13:31 -0500
Received: from mail.toke.dk (mail.toke.dk [IPv6:2a0c:4d80:42:2001::664])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164FB31346
        for <linux-wireless@vger.kernel.org>; Thu, 15 Dec 2022 07:12:51 -0800 (PST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1671117166; bh=quFkZLSHrE3H5lruIvxnUkQvAV1bY8ca9zq/RSidpP4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=cH1QITlRwEbTcZ5hzV/sOqcIXRP6u41MlUFLbgK69awQxl5BKpmm+YXN0bZiG/30e
         n8aweqmsvxSRtgNWN+cnhToDt0G4L8yUbPNTF68IFgMkoTWGV1YcIazvWdTmF8O7k7
         9fZhayHNzvt4uALWU2/V++UzoteIem/CChZ2cYLgYstaTm8PrYoOEVvjVKqjF0WoE0
         1jS9WOAlf5uAXql95zjW7BoCa2whCUYK2BpsCcV1qh5+VVS/uDaxolBGIXy9U0Y26+
         E0Sq4oZD9+56CEvvNX4dtIYuPtklQ5Mx4sNjV/VcChea1Yq1UXf/M2rpPTomgU+ApI
         HW4p2Y/tUwuow==
To:     Wenli Looi <wlooi@ucalgary.ca>
Cc:     linux-wireless@vger.kernel.org,
        Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: Re: [PATCH] ath9k: remove most hidden macro dependencies on ah
In-Reply-To: <c8369317-cf84-f0e3-fe8-9b6e22e43a6a@ucalgary.ca>
References: <c8369317-cf84-f0e3-fe8-9b6e22e43a6a@ucalgary.ca>
Date:   Thu, 15 Dec 2022 16:12:46 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87v8mcd7kh.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wenli Looi <wlooi@ucalgary.ca> writes:

> Adds an explicit _ah parameter to most macros that previously had a
> hidden dependency on ah. This makes the code more compliant with the
> style guide.
>
> This change does not appear to affect the final binary.
>
> Signed-off-by: Wenli Looi <wlooi@ucalgary.ca>

Thanks for doing the conversion! Confirmed that this does not affect the
generated .text - without patch applied:

$ for f in *.ko; do printf "%-15s: " "$f"; objdump -d $f | sha1sum; done
ath9k_common.ko: c06d542df4af8c0e7508bc6bd31fe4c826d37054  -
ath9k_hw.ko    : 23cf6dd88aa548fa21b724c5e78835481c6c5a80  -
ath9k.ko       : eaeb3016b236aafc06f2397b8e41ba85389085e6  -

after applying & rebuilding:

$ for f in *.ko; do printf "%-15s: " "$f"; objdump -d $f | sha1sum; done
ath9k_common.ko: c06d542df4af8c0e7508bc6bd31fe4c826d37054  -
ath9k_hw.ko    : 23cf6dd88aa548fa21b724c5e78835481c6c5a80  -
ath9k.ko       : eaeb3016b236aafc06f2397b8e41ba85389085e6  -


Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
