Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFC9E38C24A
	for <lists+linux-wireless@lfdr.de>; Fri, 21 May 2021 10:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbhEUIxK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 May 2021 04:53:10 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:46684 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231678AbhEUIxK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 May 2021 04:53:10 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lk0sb-0018Me-75; Fri, 21 May 2021 11:51:42 +0300
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   Luca Coelho <luca@coelho.fi>
In-Reply-To: <20210420172755.12178-1-emmanuel.grumbach@intel.com>
References: <20210420172755.12178-1-emmanuel.grumbach@intel.com>
To:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Cc:     linux-wireless@vger.kernel.org, johannes.berg@intel.com,
        tomas.winkler@intel.com, luciano.coelho@intel.com,
        gregkh@linuxfoundation.org,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.9.2
Message-Id: <E1lk0sb-0018Me-75@farmhouse.coelho.fi>
Date:   Fri, 21 May 2021 11:51:38 +0300
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: Re: [PATCH v2 1/3] mei: bus: add client dma interface
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Emmanuel Grumbach <emmanuel.grumbach@intel.com> wrote:

> From: Alexander Usyskin <alexander.usyskin@intel.com>
> 
> Expose the client dma mapping via mei client bus interface.
> The client dma has to be mapped before the device is enabled,
> therefore we need to create device linking already during mapping
> and we need to unmap after the client is disable hence we need to
> postpone the unlink and flush till unmapping or when
> destroying the device.
> 
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> Co-developed-by: Tomas Winkler <tomas.winkler@intel.com>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

3 patches applied to iwlwifi-next.git, thanks.

d0f2edda1651 iwlwifi: pcie: don't enable BHs with IRQs disabled
fc07b83286af mei: bus: add client dma interface
09df8fa50be8 iwlwifi: mei: add the driver to allow cooperation with CSME

