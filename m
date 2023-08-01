Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E28A76B7ED
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Aug 2023 16:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234812AbjHAOqs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Aug 2023 10:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234732AbjHAOqs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Aug 2023 10:46:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855F91BC5
        for <linux-wireless@vger.kernel.org>; Tue,  1 Aug 2023 07:46:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13C26615C9
        for <linux-wireless@vger.kernel.org>; Tue,  1 Aug 2023 14:46:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BF90C433C8;
        Tue,  1 Aug 2023 14:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690901206;
        bh=eysD334a/e4x0k2iTCQjKNAdchsbBdsUp7x+V0SJiGs=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=dVd0IZYPFg9MdJXySlxF73PaODtSkl98QkpweODAM4enIKJ//pwWMzYEc/q4zUaBw
         we9vX3SyM39LVRAuzfjWeI0H8U/FVaskX3Go/kYALQysdRYrsmZVNUyjyhZfdi0dTo
         g9neyEvFhL82Mud0yL1m9zcoR2sH97J3/9Po37wq66S03Q83lsJjSkfl//w67WH/bn
         DtHT6GHgFk9abmkECzPqQZMrX4jgRjCP0VPyIXr/80C/6IhCY1+RIN4/+qnmmyOcSw
         ByNMjspUsn4qy7uDp8Zx5w+MqloSjmXZMdRyIQXH5XKl7JoxbodG9ln056e3MBwZWM
         bvlKElhVQoFfQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: wilc1000: remove use of has_thrpt_enh3 flag
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230710094401.235222-1-prasurjya.rohansaikia@microchip.com>
References: <20230710094401.235222-1-prasurjya.rohansaikia@microchip.com>
To:     <Prasurjya.Rohansaikia@microchip.com>
Cc:     <linux-wireless@vger.kernel.org>, <Ajay.Kathat@microchip.com>,
        <Claudiu.Beznea@microchip.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169090120365.212423.12471635260989759288.kvalo@kernel.org>
Date:   Tue,  1 Aug 2023 14:46:45 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<Prasurjya.Rohansaikia@microchip.com> wrote:

> From: Prasurjya Rohan Saikia <prasurjya.rohansaikia@microchip.com>
> 
> The 'enhance throughput flow' algorithm is used by default. So older
> sections of the code are removed so as to always use this new algorithm.
> 
> Signed-off-by: Prasurjya Rohan Saikia <prasurjya.rohansaikia@microchip.com>
> Acked-by: Ajay Kathat <ajay.kathat@microchip.com>

Patch applied to wireless-next.git, thanks.

646462f860f1 wifi: wilc1000: remove use of has_thrpt_enh3 flag

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230710094401.235222-1-prasurjya.rohansaikia@microchip.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

