Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED347EE1A3
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Nov 2023 14:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345225AbjKPNjc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Nov 2023 08:39:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344962AbjKPNjb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Nov 2023 08:39:31 -0500
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E4BD5A
        for <linux-wireless@vger.kernel.org>; Thu, 16 Nov 2023 05:39:27 -0800 (PST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1700141962; bh=xz/iIZuRY8Op5WtoC1hs7ryH78Y6fd9GbW1inUZsj3M=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=CTDHL+/IzwlYYfT58IfEP+UsddbyIZ9mdusYQH+NvNEqXFUTGdZZtBE7T6+QFtrlw
         48Gu2yY92JWcInAMHeTbZwuhpjHvkUeRUmyOZJ9IfNr4IC5ZUbAjDVWhinxqB1NHsk
         5UTCD2YcUNI2M1Q4DAUIbgrGaRSCnB8e0u6QVI5ATYK8g5ttO8E6ZodsU38KF0OhPT
         3mZMgSdASmET9BYE4k+iN70F5qAhsDw3odiBiRkbNjTwSy2vEakHTpL7Db/pUtFPB0
         RRv7ceCoyyz/SwNk94NXWITaVPwVpggpmLHltTv/KpBXFYcD+iiQR7eV+yRbDdUBKg
         ysi6eWVgYQjpQ==
To:     Wu Yunchuan <yunchuan@nfschina.com>, kvalo@kernel.org,
        afaerber@suse.de, mani@kernel.org
Cc:     linux-wireless@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Wu Yunchuan <yunchuan@nfschina.com>
Subject: Re: [PATCH v2 wireless-next 9/9] wifi: ath9k: Remove unnecessary
 (void*) conversions
In-Reply-To: <20230919045226.524544-1-yunchuan@nfschina.com>
References: <20230919045226.524544-1-yunchuan@nfschina.com>
Date:   Thu, 16 Nov 2023 14:39:22 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87o7ftddh1.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wu Yunchuan <yunchuan@nfschina.com> writes:

> No need cast (void *) to (struct owl_ctx *), (struct ath_hw *),
> (struct cmd_buf *) or other types.
>
> Signed-off-by: Wu Yunchuan <yunchuan@nfschina.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
