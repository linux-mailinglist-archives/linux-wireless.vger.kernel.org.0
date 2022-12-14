Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20DD064C493
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Dec 2022 09:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236598AbiLNIC1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Dec 2022 03:02:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiLNICX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Dec 2022 03:02:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0451EAE9
        for <linux-wireless@vger.kernel.org>; Wed, 14 Dec 2022 00:02:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EDB8061752
        for <linux-wireless@vger.kernel.org>; Wed, 14 Dec 2022 08:02:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68206C433D2;
        Wed, 14 Dec 2022 08:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671004941;
        bh=TdhhX5mo5F+m44dE+iKJI17Zo+Fpzyvj5Bw5zAasLOM=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=exnClfQqLV0OXE3zcXodsxquz07wzH0NiADnI9wwJ+KjLytinbrowUOSqUN3dWW4U
         4kfnWZ2M79J3eYrZim58K5OX6e80McpzvGDMhYuKKl1URibXq92QeKyWXcYP1FZ1x3
         wwrDgF7OZhFILghUr9Nf17j6mAEpDCt5zJFmTsfkELHqCPseG1Xjz63pHqFLwD0rlI
         NKkv99gghVIWMeFv5YX3QkLxZGyaVG5f9QPPuqhG01SuvT8fcNYr1VjtJVbVSxtNIW
         9142Do+1ZzRC3fuc2kK3nDXHlguwF8CpZ0HpiWvwENVa7IkYCWjy8OPbRxM2ZxUVD/
         E0/l7Cv/zbtvw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Muna Sinada <quic_msinada@quicinc.com>
Cc:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>,
        Aloka Dixit <quic_alokad@quicinc.com>
Subject: Re: [RFC 1/4] wifi: nl80211: advertise RU puncturing support to userspace
References: <1670006154-6092-1-git-send-email-quic_msinada@quicinc.com>
        <1670006154-6092-2-git-send-email-quic_msinada@quicinc.com>
Date:   Wed, 14 Dec 2022 10:02:18 +0200
In-Reply-To: <1670006154-6092-2-git-send-email-quic_msinada@quicinc.com> (Muna
        Sinada's message of "Fri, 2 Dec 2022 10:35:51 -0800")
Message-ID: <87tu1yl8fp.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Muna Sinada <quic_msinada@quicinc.com> writes:

> From: Aloka Dixit <quic_alokad@quicinc.com>
>
> RU preamble puncturing is allowed for bandwidths more than 80 MHz
> except 80+80. Drivers may not support puncturing at all or have
> restrictions for a minimum bandwidth.
> Add new attribute NL80211_ATTR_RU_PUNCT_SUPP_BW to advertise the
> driver support to the userspace. Default value (0) will indicate that
> RU puncturing is not supported.
>
> Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>

Missing submitter's s-o-b.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
