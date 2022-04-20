Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E173B50879B
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Apr 2022 14:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378371AbiDTMD5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Apr 2022 08:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378369AbiDTMDz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Apr 2022 08:03:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9482403F2
        for <linux-wireless@vger.kernel.org>; Wed, 20 Apr 2022 05:01:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6EA5AB81D1C
        for <linux-wireless@vger.kernel.org>; Wed, 20 Apr 2022 12:01:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4790AC385A0;
        Wed, 20 Apr 2022 12:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650456067;
        bh=nk4gtEIVFB3gGyhqelVo/c8jgVq/CIxgTBV7TEK6Fd8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=t+aWmJ+vAEF0tAJcG9ISeMItmw1bjeaO9vJGHHGdHLHS6Ay1AZbKKaoms5R7cCZXY
         ZTEqVs9nVnZ/Qy7imQLtaZCBEIrhYzc/sPps4pPyk9s6Scb6se7I5dafmqk6MWMnk4
         /9I53O0rTWJl5Ptc4gibppkLB63kuUUHGFtvGv5BgKdb3aKJksL0bH2hkJwJEdPndO
         DhWSVWJOPpxS6tNwX3L1dYwUjqEWJa9J9TDyhEf13Z0/jWd2xHhPBbeAB9vh6K4mcT
         3SXCzYOIthURjmNQVvBtso7aehvlnwYgMpXJ+2KAv2dj6tFjncID4MyC742NkHoRKD
         qVmrBUU57epRw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Wenli Looi <wlooi@ucalgary.ca>
Cc:     Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        linux-wireless@vger.kernel.org, ath9k-devel@qca.qualcomm.com
Subject: Re: [PATCH 2/9] ath9k: basic support for QCN550x
References: <20220418071313.882179-1-wlooi@ucalgary.ca>
        <20220418071313.882179-3-wlooi@ucalgary.ca>
Date:   Wed, 20 Apr 2022 15:01:04 +0300
In-Reply-To: <20220418071313.882179-3-wlooi@ucalgary.ca> (Wenli Looi's message
        of "Mon, 18 Apr 2022 00:13:06 -0700")
Message-ID: <87pmlcnev3.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wenli Looi <wlooi@ucalgary.ca> writes:

> QCN550x is very similar to QCA956x. Note that AR_CH0_XTAL is
> intentionally unchanged. Certain arrays are no longer static because
> they are no longer constant.

s-o-b missing in patches 2-5.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
