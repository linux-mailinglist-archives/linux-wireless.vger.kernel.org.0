Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F87350C916
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Apr 2022 12:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234780AbiDWKLz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 23 Apr 2022 06:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiDWKLw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 23 Apr 2022 06:11:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1B11B1
        for <linux-wireless@vger.kernel.org>; Sat, 23 Apr 2022 03:08:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37AEE60F24
        for <linux-wireless@vger.kernel.org>; Sat, 23 Apr 2022 10:08:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2931C385A5;
        Sat, 23 Apr 2022 10:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650708534;
        bh=ogyQbiHrQpnUX0/aC7NJX0rW89dZuZAwwBzIsZ2eN1I=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=PJtmZStzCqYCU3SLza7x8weW+r8vp82Zy4MBbh1AEoXlnn8bpm6I5eHquPREkeGjS
         iREt3T7ygBZMpe8emdoIDWeEpxhAZhrgHAOCmFbzDdyWACUP3eOpxlT1CGyu+Gke1c
         XLGyeV+2zet2VVBVlfg7tYeJSWIipp2uIQQzTZvjhYbhqxWEm52JXZ+CDovet4+WKN
         kmJRWQOE8vaKYXYwhoN+KLTDEm5nCdzRIuopIPouZcyCoUhKnq5oXrYlTeQFojVWWt
         aaIeby3HsEb4BpxzcioDr+aSonfSMA0qo+cBN4ku6A2lWV0LyhEj6RUl98nIls/Abp
         dnXBsBveDHnMg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Cheng Wang <quic_chengwan@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2] ath11k: add register read debugfs interface for WCN6855
References: <20220207084540.3661100-1-quic_chengwan@quicinc.com>
Date:   Sat, 23 Apr 2022 13:08:50 +0300
In-Reply-To: <20220207084540.3661100-1-quic_chengwan@quicinc.com> (Cheng
        Wang's message of "Mon, 7 Feb 2022 16:45:40 +0800")
Message-ID: <871qxokt71.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Cheng Wang <quic_chengwan@quicinc.com> writes:

> Add debugfs interface reg_addr/reg_value and use these two interfaces
> to read register value.
> For example, execute the following commands to read WCN6855 HW register of
> =E2=80=9Cmemtype=3D0xa offset=3D0x3a00d0=E2=80=9D:
>
> $ echo 0xa 0x3a00d0>reg_addr
> $ cat reg_value
> 0x10200000
>
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICO=
NZ_LITE-1
>
> Signed-off-by: Cheng Wang <quic_chengwan@quicinc.com>
> ---
> v2: change per comments from Kalle
>     fixes new warnings.

I had already made changes in v1 so I'll use that instead:

https://patchwork.kernel.org/project/linux-wireless/patch/20220125063731.30=
49556-1-quic_chengwan@quicinc.com/

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
