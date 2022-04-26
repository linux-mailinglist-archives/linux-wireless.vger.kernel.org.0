Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08EB950FA66
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Apr 2022 12:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348795AbiDZK3v (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Apr 2022 06:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349014AbiDZK3I (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Apr 2022 06:29:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2E7329A0
        for <linux-wireless@vger.kernel.org>; Tue, 26 Apr 2022 03:03:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBF0861516
        for <linux-wireless@vger.kernel.org>; Tue, 26 Apr 2022 10:03:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66BFCC385A0;
        Tue, 26 Apr 2022 10:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650967387;
        bh=r3768dlHCT62Q2lOLUs6ZoPdNR4ReDkH5elN6FS+lHE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=rWo2crH4IjZZrAZZZzHE8VrA91/fGW0Czq+aCJbv+AqMNiKTfc82CAKbt6CZyx2qi
         XPgEmXUNGiScreV75xzPcgiGvcpMYrB/xUycS4akzupmQ1tnHZOosuGPXYAL65XL8a
         QCDAwmvYLSn7KtiIuOboNGr7rOZXAm7O0UW9YBjEVSJT/DYvmyOuXa88n0CeFBUNzP
         ctGRUink1xnUE264NPy86cJGgwCbG1mkOxbmWmDixFwAhMmOYlMoD+2t0+hW9Eygu0
         ojrsl1HBrrXX0WeaH4eV/aduZq3zoQjQDbfV5l8Z77O2rRZzQ6DGTd3qdSjvz0acEb
         QslqWM8uV05ZA==
From:   Kalle Valo <kvalo@kernel.org>
To:     "Hari Chandrakanthan \(QUIC\)" <quic_haric@quicinc.com>
Cc:     "ath11k\@lists.infradead.org" <ath11k@lists.infradead.org>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] ath11k: disable spectral scan during spectral deinit
In-Reply-To: <CY4PR02MB32702916194AF1DD0AAD009183FB9@CY4PR02MB3270.namprd02.prod.outlook.com>
        (Hari Chandrakanthan's message of "Tue, 26 Apr 2022 09:55:57 +0000")
References: <1649396345-349-1-git-send-email-quic_haric@quicinc.com>
        <87fsmooz83.fsf@kernel.org> <87levzohyk.fsf@kernel.org>
        <CY4PR02MB32702916194AF1DD0AAD009183FB9@CY4PR02MB3270.namprd02.prod.outlook.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
Date:   Tue, 26 Apr 2022 13:03:02 +0300
Message-ID: <877d7cjh61.fsf@kernel.org>
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

"Hari Chandrakanthan (QUIC)" <quic_haric@quicinc.com> writes:

> Tested-on: QCN6122 hw1.0 AHB WLAN.HK.2.6.0.1-00851-QCAHKSWPL_SILICONZ-1

QCN6122 is not yet supported in upstream, so I guess you are testing
something else than upstream? That's not good.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
