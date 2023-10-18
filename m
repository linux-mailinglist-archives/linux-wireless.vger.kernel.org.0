Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A7C7CD680
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Oct 2023 10:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344668AbjJRIaN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Oct 2023 04:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235190AbjJRIaH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Oct 2023 04:30:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E813EF7
        for <linux-wireless@vger.kernel.org>; Wed, 18 Oct 2023 01:30:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A680C433C9;
        Wed, 18 Oct 2023 08:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697617805;
        bh=p7qtdS3dP5TCiZktRCL3CVf1Ih72w/1xVDE1TzIdIHw=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Wdu6EOeEjwGiOK8JyqPu247OpNo5L+cYUyXg68WZP/UUSwNqyPzCV+YvKkMXEkgIE
         v1uJ/9WUQz93TkNFR7sMQWOVipaE15lwXVicG4jH6ifo/dV40cJexvqkzsG8RNhc1M
         KEP9K9SjD/1YocKyDiFdi8naJZb92tIXSPw0HlKqslHTwrY3KDDua6rqpAFFaXaj5l
         GgLyxrA+/2bXX8ssW4Hm67udkFNMxKc2bxwKjci1iQv1PjSJJaqJPnrpmGdNOaCOVc
         FesSb4px7bdPzwEidre0Ym7OdGR2YNS6WHHlJR7Q0uggKtdqbNrJl4rl24bpb33K/u
         UVlLlSC7gmD+A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] wifi: ath12k: register EHT mesh capabilities
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231013070007.25597-3-quic_rgnanase@quicinc.com>
References: <20231013070007.25597-3-quic_rgnanase@quicinc.com>
To:     Ramya Gnanasekar <quic_rgnanase@quicinc.com>
Cc:     ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Ramya Gnanasekar <quic_rgnanase@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169761780232.48072.9283113948539025613.kvalo@kernel.org>
Date:   Wed, 18 Oct 2023 08:30:04 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ramya Gnanasekar <quic_rgnanase@quicinc.com> wrote:

> The capabilities for the EHT mesh are generated from the capabilities
> reported by the firmware. But the firmware only reports the overall
> capabilities and not the one which are specific for mesh.
> 
> Capabilities which requires infrastructure setup with a main STA(AP)
> controlling operations are not needed for mesh and hence remove these
> capabilities from the list.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0-02903-QCAHKSWPL_SILICONZ-1
> Signed-off-by: Ramya Gnanasekar <quic_rgnanase@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

2 patches applied to ath-next branch of ath.git, thanks.

6b819f89c482 wifi: ath12k: register EHT mesh capabilities
3e9942fbdf4d wifi: ath12k: Enable Mesh support for QCN9274

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231013070007.25597-3-quic_rgnanase@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

