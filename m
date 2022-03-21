Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9C14E2D11
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Mar 2022 17:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350605AbiCUQET (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Mar 2022 12:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346093AbiCUQES (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Mar 2022 12:04:18 -0400
Received: from mail.toke.dk (mail.toke.dk [IPv6:2a0c:4d80:42:2001::664])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489DD53A7E
        for <linux-wireless@vger.kernel.org>; Mon, 21 Mar 2022 09:02:53 -0700 (PDT)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1647878571; bh=RGX/pL6BjU5Qbe2G5FH6NdgJThPnBMh0S8B2LYMTuQw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=cBXAuTJej9UhXpSjud9ajXgQCe0vB6cYKI1ULC/hLx7YlelBWIvoGjuhqp+96CFgp
         S56dZRg9QzyGkOA70aToT5/mPkIoQJQEfcT9PxInDclliGI/DvNfuGtxZl9e50Ppqe
         HCUl7Gep6a/PLVZdk6PQ4/ZODXYPp3uNinizAfvR/fFgsKMAugNxaqEFy4AWmrVyb9
         16b7oV7XCtK1/4pJL88dLGZskPF0dZuUV6SoUYG9zQ65Oqsj3pVSRLhSfNF+WGwmnk
         DPb2fKIuseeW9iblMkqV+4T5dkTHDfQ4WF1OunTwXcu02EywkyT94bN03IH0L9uRHF
         /vmfQi3R87GfA==
To:     Wenli Looi <wlooi@ucalgary.ca>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        ath9k-devel@qca.qualcomm.com, Wenli Looi <wlooi@ucalgary.ca>
Subject: Re: [PATCH 2/6] ath9k: split set11nRateFlags and set11nChainSel
In-Reply-To: <20220320233010.123106-3-wlooi@ucalgary.ca>
References: <20220320233010.123106-1-wlooi@ucalgary.ca>
 <20220320233010.123106-3-wlooi@ucalgary.ca>
Date:   Mon, 21 Mar 2022 17:02:51 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <871qyv9tuc.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wenli Looi <wlooi@ucalgary.ca> writes:

> This makes the code clearer since set11nRateFlags currently sets
> both the rate flags and chain sel. This may also be required for
> QCN550x support, where the rate flags and chain sel are in separate
> fields.
>
> This change does not appear to affect the final binary.
>
> Signed-off-by: Wenli Looi <wlooi@ucalgary.ca>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
