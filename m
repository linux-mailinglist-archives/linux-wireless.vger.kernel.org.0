Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F014B3640
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Feb 2022 17:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236890AbiBLQLQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 12 Feb 2022 11:11:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbiBLQLQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 12 Feb 2022 11:11:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073D5197
        for <linux-wireless@vger.kernel.org>; Sat, 12 Feb 2022 08:11:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B4710B8069A
        for <linux-wireless@vger.kernel.org>; Sat, 12 Feb 2022 16:11:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56CFEC340E7;
        Sat, 12 Feb 2022 16:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644682268;
        bh=S+J3OYPkNVUKura8Xz5Q42vkvZ472WVCdeIPO5pUKIA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eeOcxT7CDGAwQHP4OIb/+vh7tK5caLiJ5JPLSO0F+T66Fv838cTN1SCb6v3GQA103
         nghI9s5REB4L2QUTJGHjoqDx56PAHPoh6w59UZkBEMmcBDaioeUn+mS2KdtSPAEsZE
         CSc7j6QsEAzIkGqiZR5pf+2+Ajn7pgP650v3sWE5oxyD+LF7TtILuhc/75/RECxgrn
         wWe16KeBQBzdBxIGrJhhsAl9hIEwFCBgVBEwl/d+tuql+vSV6ninaFS6Ft2kOOLn/g
         AC1kagq/QUKATkuzLAfc2IthgLZ3SKUs9d3XLbbDCAa0T03tcDQZI2Q9j1qz8/Y2x5
         3//ZNObOT2x5w==
Date:   Sat, 12 Feb 2022 10:11:07 -0600
From:   Seth Forshee <sforshee@kernel.org>
To:     Xose Vazquez Perez <xose.vazquez@gmail.com>
Cc:     WIRELESS ML <linux-wireless@vger.kernel.org>,
        REGDB ML <wireless-regdb@lists.infradead.org>
Subject: Re: [PATCH] wireless-regdb: Update regulatory rules for Spain (ES)
 on 6GHz
Message-ID: <YgfcG607RHL28pOP@ubuntu-x1>
References: <20220202225157.91989-1-xose.vazquez@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220202225157.91989-1-xose.vazquez@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_50,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Feb 02, 2022 at 11:51:57PM +0100, Xose Vazquez Perez wrote:
> Add WiFi 6E frequency band.
> 
> Sources:
> (EU) 2021/1067: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX%3A32021D1067
> BOE numero 308, de 24/12/202: Orden ETD/1449/2021: CNAF-2021 (page 302): https://www.boe.es/buscar/pdf/2021/BOE-A-2021-21346-consolidado.pdf
> 
> UN-167 RLANs en 6 GHz
> 
> Aplicaciones de uso común en la banda de 5945-6425 MHz.
> 
> De conformidad con la Decisión de Ejecución (UE) 2021/1067 de la Comisión, sobre el uso
> armonizado de la banda 5945-6425 MHz para sistemas de acceso inalámbrico, incluidas las
> redes de área local (WAS/RLAN), se permiten estas aplicaciones en la citada banda de
> frecuencias bajo la consideración de uso común con arreglo a las condiciones técnicas
> indicadas en el anexo a la citada Decisión.
> 
> Los dispositivos de baja potencia para uso en interiores (LPI), tendrán una potencia máxima
> de 23 dBm (p.i.r.e.), con una densidad de potencia p.i.r.e. media máxima de 10 dBm/MHz
> para las emisiones en banda y de -22 dBm/MHz para emisiones fuera de banda.
> 
> Los dispositivos de muy baja potencia para uso en interiores y en exteriores (VLP), tendrán
> una potencia máxima de 14 dBm (p.i.r.e.), con una densidad de potencia p.i.r.e. media
> máxima de 1 dBm/MHz para emisiones en banda, o hasta 10 dBm/MHz si funcionan con
> canalización que no supere los 20 MHz, y de -45 dBm/MHz para emisiones fuera de banda.
> 
> En cualquier caso, estos dispositivos deberán utilizar técnicas de acceso al espectro y
> mitigación de interferencias que garanticen los requisitos esenciales de la Directiva
> 2014/53/UE.
> 
> Cc: Seth Forshee <sforshee@kernel.org>
> Cc: WIRELESS ML <linux-wireless@vger.kernel.org>
> Cc: REGDB ML <wireless-regdb@lists.infradead.org>
> Signed-off-by: Xose Vazquez Perez <xose.vazquez@gmail.com>

Applied, thanks!
