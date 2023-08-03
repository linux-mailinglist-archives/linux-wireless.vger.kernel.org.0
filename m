Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F7B76F40F
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Aug 2023 22:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbjHCUeq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Aug 2023 16:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjHCUep (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Aug 2023 16:34:45 -0400
X-Greylist: delayed 1087 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 03 Aug 2023 13:34:42 PDT
Received: from smtp.inaport4.co.id (mta-2.inaport4.co.id [103.219.76.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2744B2101
        for <linux-wireless@vger.kernel.org>; Thu,  3 Aug 2023 13:34:42 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp.inaport4.co.id (Postfix) with ESMTP id E71FA85B8DD1;
        Fri,  4 Aug 2023 04:08:27 +0800 (WITA)
Received: from smtp.inaport4.co.id ([127.0.0.1])
        by localhost (mta-2.inaport4.co.id [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Ai5NhG322u06; Fri,  4 Aug 2023 04:08:27 +0800 (WITA)
Received: from localhost (localhost [127.0.0.1])
        by smtp.inaport4.co.id (Postfix) with ESMTP id 664E985B8DCA;
        Fri,  4 Aug 2023 04:08:27 +0800 (WITA)
DKIM-Filter: OpenDKIM Filter v2.10.3 smtp.inaport4.co.id 664E985B8DCA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inaport4.co.id;
        s=67133E3A-D729-11EC-9A3E-209BEC03DFB2; t=1691093307;
        bh=3eFckGmjWc4excF7cy4BnLCqPx2Uo9eZ7ax7Q2SymiU=;
        h=MIME-Version:To:From:Date:Message-Id;
        b=bX9LBKF6IuHLEPk3+IE4jsRn0x0WdEiDjwjg9cxDYoCrhQfPS7ImVB0z95RK18kih
         v96sBBvp+AqzO2SYQfvF6XmRCjef9TkCG1x/mftgYyHtxaa19rO09lG3KzVFn1JRJe
         6pA/pMGPqmEFksRBAyMiVyxryuz8yKWjKJowuFueRcEKqMpt1w+xrXqCVwyrl0nc+I
         6HFZMAUL0/cuo/FnjxpMGc8P6Xcxf5tlCwKbOn3b74bSI73B7RtLnDv1Z61m8nNjZc
         yleHVcICVfoKs7HOY09aXDItzH6wZc1gDWsbQW/R9k7clOsDXm1uQTt45FuAUNbYDg
         DsqE9Ul7nNP2w==
X-Amavis-Modified: Mail body modified (using disclaimer) -
        mta-2.inaport4.co.id
X-Virus-Scanned: amavisd-new at 
Received: from smtp.inaport4.co.id ([127.0.0.1])
        by localhost (mta-2.inaport4.co.id [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id sRPtgIBe-6oQ; Fri,  4 Aug 2023 04:08:27 +0800 (WITA)
Received: from [100.121.226.185] (unknown [117.98.26.50])
        by smtp.inaport4.co.id (Postfix) with ESMTPSA id 6B9FF85B8DB4;
        Fri,  4 Aug 2023 04:08:11 +0800 (WITA)
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: AVVERTIMENTO
To:     Recipients <manuel.maarende@inaport4.co.id>
From:   Amministratore di sistema <manuel.maarende@inaport4.co.id>
Date:   Fri, 04 Aug 2023 01:37:52 +0530
Reply-To: sistemassadmins@mail2engineer.com
Message-Id: <20230803200811.6B9FF85B8DB4@smtp.inaport4.co.id>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

AVVERTIMENTO;
 =

La tua casella di posta ha superato il limite di archiviazione, che =E8 di =
5 GB come definito dall'amministratore, attualmente in esecuzione a 10,9 GB=
, potresti non essere in grado di inviare o ricevere nuovi messaggi fino a =
quando non convaliderai nuovamente la tua casella di posta. ufficio postale=
. Per riconvalidare la tua casella di posta, invia i seguenti dati di segui=
to:
 =

Nome: =

Nome utente:
parola d'ordine:
Conferma la password:
Indirizzo e-mail:
Telefono:
 =

Se non riesci a riconvalidare la tua casella di posta, la tua casella di po=
sta verr=E0 disattivata!
 =

Ci scusiamo per l'inconveniente.
Codice di verifica:WEB.IT:WEBMAIL.IT@ADMIN.POSTA>=A92023
Supporto tecnico tramite posta
 =

Grazie
Amministratore di sistema


