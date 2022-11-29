Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8DD63C6AF
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Nov 2022 18:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236124AbiK2Rq6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Nov 2022 12:46:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbiK2Rq6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Nov 2022 12:46:58 -0500
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DA354B1B
        for <linux-wireless@vger.kernel.org>; Tue, 29 Nov 2022 09:46:56 -0800 (PST)
Received: (wp-smtpd smtp.wp.pl 16798 invoked from network); 29 Nov 2022 18:46:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1669744011; bh=ILLcT4WS3rS+gDqY1tRV38ue5NVY73E0E0M2/l/vwys=;
          h=From:To:Cc:Subject;
          b=bwQwnlVgrmVKm5sGagmx8Bl4WtyyxM3V1QabRhZrQYi3unyK3sYDvCBP2OcU7HdQH
           e4a9PxtW7GoxlllXNaaZnMzEnZlal1AK99+1jmjaRpKpFH/0evaKfhwiPGox3Kql3m
           GJzhtboBNtGtqPVwHjT80ybHx955fFvx5yF5GdBE=
Received: from 89-64-15-29.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.15.29])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <jnyb.de@gmail.com>; 29 Nov 2022 18:46:50 +0100
Date:   Tue, 29 Nov 2022 18:46:50 +0100
From:   Stanislaw Gruszka <stf_xl@wp.pl>
To:     Ioannis Barkas <jnyb.de@gmail.com>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: PRO/Wireless 4965 Intel WPA2,3 SSID connection problem #1
Message-ID: <20221129174650.GA620872@wp.pl>
References: <CADUzMVb6QKX-dhVpFXvUJ2MXMf93vK1RC+R8JqAPxExBSisA0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADUzMVb6QKX-dhVpFXvUJ2MXMf93vK1RC+R8JqAPxExBSisA0A@mail.gmail.com>
X-WP-MailID: 47f8432ffa0790db3ade368606849fdc
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [IQPU]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Ioannis

On Tue, Nov 29, 2022 at 12:34:38AM +0200, Ioannis Barkas wrote:
> I have figured everything out with MX Linux and created a new kernel
> based on 6.0 that it works well on my test PC as well. Then I applied
> your patch along with some debugging options. Unfortunately the
> problem remains and it continues to be unable to connect at the
> desired WPA2,3 based network.

Regarding patch, it was for UBSAN error, but looking at your other emails,
the problem you have is more general. I think you should try swcrypto=1
module option.

Regards
Stanislaw

