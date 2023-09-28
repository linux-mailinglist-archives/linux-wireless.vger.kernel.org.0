Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D94C7B20A0
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Sep 2023 17:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjI1PMJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Sep 2023 11:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbjI1PMI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Sep 2023 11:12:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4311A4
        for <linux-wireless@vger.kernel.org>; Thu, 28 Sep 2023 08:12:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44486C433C7;
        Thu, 28 Sep 2023 15:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695913927;
        bh=CZuE83sl18ITQX4RMFfwg27QZ2DFezUk3bkCbIdbRtU=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Vz2FruwDfiWe1kY3EO7OnYK5TFKTYl0gtHtuwVJx4FXsVP9YkbxanIAmEmlbV0n11
         jhGqNgLFNCEDIy0CGFGn8A6LylxDNx8Mh3UlNMIctkdL8SvfEC6xRAc7K7XKwwVcdx
         XYQKiGbz9GjeRnxkBjS5am93jBXhTpH97aZzV1buBTcBQpGyLY0jyLjhSqHRBBnJSp
         vJbTFWm1r+v8vXRAc/bqE3zBDTDxEAZK58kjTWwamDPYpb/Gy/Jo+lCKLOFWizNYqP
         LaFemXWphob1FVbg+v6BEjLr7a1kYoMBc0GGeDUQ+AssavyLErH28NgcMz6HR0wcQU
         qiWrhbs2gWU+w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: ath12k: Set default beacon mode to burst mode
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230905213943.12275-1-quic_sidhanta@quicinc.com>
References: <20230905213943.12275-1-quic_sidhanta@quicinc.com>
To:     Sidhanta Sahu <quic_sidhanta@quicinc.com>
Cc:     ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Sidhanta Sahu <quic_sidhanta@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169591392416.3019228.2935423910724687574.kvalo@kernel.org>
Date:   Thu, 28 Sep 2023 15:12:06 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sidhanta Sahu <quic_sidhanta@quicinc.com> wrote:

> Currently, firmware does not like when beacon mode is set as staggered
> mode for more than one beaconing vifs. Beacon mode for multiple
> beaconing (transmitted) vifs are expected to be in burst mode. So set
> beacon mode to burst mode by default.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Sidhanta Sahu <quic_sidhanta@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

c4cb46dfb291 wifi: ath12k: Set default beacon mode to burst mode

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230905213943.12275-1-quic_sidhanta@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

