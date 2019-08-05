Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 232B081FC2
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2019 17:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbfHEPGO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Aug 2019 11:06:14 -0400
Received: from bsmtp8.bon.at ([213.33.87.20]:31338 "EHLO bsmtp8.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729199AbfHEPGO (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Aug 2019 11:06:14 -0400
X-Greylist: delayed 2809 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Aug 2019 11:06:06 EDT
Received: from bsmtp7.bon.at (unknown [192.168.181.107])
        by bsmtp8.bon.at (Postfix) with ESMTPS id 462Kdf0RMfz5trg
        for <linux-wireless@vger.kernel.org>; Mon,  5 Aug 2019 16:19:18 +0200 (CEST)
Received: from [10.1.14.125] (vpn.streamunlimited.com [91.114.0.140])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 462Kdc6bcZz5tlF;
        Mon,  5 Aug 2019 16:19:16 +0200 (CEST)
To:     seth.forshee@canonical.com
Cc:     linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
From:   Emil Petersky <emil.petersky@streamunlimited.com>
Subject: [PATCH] wireless-regdb: Fix ranges of EU countries as they are
 harmonized since 2014...
Openpgp: preference=signencrypt
Message-ID: <bf327181-521b-e1ce-c5c8-81b828fc65b6@streamunlimited.com>
Date:   Mon, 5 Aug 2019 16:19:16 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch unites entries for EU countries, as they have been harmonized
latest by July 2014...
EU decision 2005/513/EC:
https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02005D0513-20070213
EU decision 2006/771/EC:
https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02008D0432-20080611

Signed-off-by: Emil Petersky <emil.petersky@streamunlimited.com>

---
diff --git a/db.txt b/db.txt
index 37393e6..907b424 100755
--- a/db.txt
+++ b/db.txt
@@ -87,12 +87,20 @@ country AS: DFS-FCC
 	(5490 - 5730 @ 160), (24), DFS
 	(5735 - 5835 @ 80), (30)
 
+# AT as part of EU/CEPT accepted decisions 2005/513/EC (5GHz RLAN, EN 301 893) 
+# and 2006/771/EC (amended by 2008/432/EC, Short-Range Devices, EN 300 440)
+#  EU decision 2005/513/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02005D0513-20070213
+#  EU decision 2006/771/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02008D0432-20080611
+# AT: https://www.rtr.at/en/tk/Spektrum5GHz/1997_bmvit-info-052010en.pdf
+# AT: acceptance https://www.ris.bka.gv.at/Dokumente/BgblAuth/BGBLA_2014_II_63/BGBLA_2014_II_63.pdfsig
 country AT: DFS-ETSI
-	(2402 - 2482 @ 40), (20)
-	(5170 - 5250 @ 80), (20), AUTO-BW, wmmrule=ETSI
-	(5250 - 5330 @ 80), (20), DFS, AUTO-BW, wmmrule=ETSI
-	(5490 - 5710 @ 160), (27), DFS, wmmrule=ETSI
-	# 60 GHz band channels 1-4, ref: Etsi En 302 567
+	(2400 - 2483.5 @ 40), (100 mW)
+	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
+	(5250 - 5350 @ 80), (100 mW), NO-OUTDOOR, DFS, AUTO-BW, wmmrule=ETSI
+	(5470 - 5725 @ 160), (500 mW), DFS, wmmrule=ETSI
+	# short range devices (ETSI EN 300 440-1)
+	(5725 - 5875 @ 80), (25 mW)
+	# 60 GHz band channels 1-4 (ETSI EN 302 567)
 	(57000 - 66000 @ 2160), (40)
 
 # Source:
@@ -139,12 +147,22 @@ country BD: DFS-JP
 	(2402 - 2482 @ 40), (20)
 	(5735 - 5835 @ 80), (30)
 
+# BE as part of EU/CEPT accepted decisions 2005/513/EC (5GHz RLAN, EN 301 893) 
+# and 2006/771/EC (amended by 2008/432/EC, Short-Range Devices, EN 300 440)
+#  EU decision 2005/513/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02005D0513-20070213
+#  EU decision 2006/771/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02008D0432-20080611
+# BE: https://www.ibpt.be/public/files/en/21760/B03-01_2.1_EN.pdf
+# BE: https://www.ibpt.be/public/files/en/21761/B03-02_2.1_EN.pdf
+# BE: https://www.ibpt.be/public/files/en/21762/B03-03_2.1_EN.pdf
+# BE: https://www.ibpt.be/public/files/en/22165/B01-28_3.1_EN.pdf
 country BE: DFS-ETSI
-	(2402 - 2482 @ 40), (20)
-	(5170 - 5250 @ 80), (20), AUTO-BW, wmmrule=ETSI
-	(5250 - 5330 @ 80), (20), DFS, AUTO-BW, wmmrule=ETSI
-	(5490 - 5710 @ 160), (27), DFS, wmmrule=ETSI
-	# 60 GHz band channels 1-4, ref: Etsi En 302 567
+	(2400 - 2483.5 @ 40), (100 mW)
+	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
+	(5250 - 5350 @ 80), (100 mW), NO-OUTDOOR, DFS, AUTO-BW, wmmrule=ETSI
+	(5470 - 5725 @ 160), (500 mW), DFS, wmmrule=ETSI
+	# short range devices (ETSI EN 300 440-1)
+	(5725 - 5875 @ 80), (25 mW)
+	# 60 GHz band channels 1-4 (ETSI EN 302 567)
 	(57000 - 66000 @ 2160), (40)
 
 country BF: DFS-FCC
@@ -167,23 +185,30 @@ country BF: DFS-FCC
 #
 # Note: The transmit power limits in the 5250-5350 MHz and 5470-5725 MHz bands
 # can be raised by 3 dBm if TPC is enabled. Refer to BDS EN 301 893 for details.
+#
+# BG as part of EU/CEPT accepted decisions 2005/513/EC (5GHz RLAN, EN 301 893) 
+# and 2006/771/EC (amended by 2008/432/EC, Short-Range Devices, EN 300 440)
+#  EU decision 2005/513/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02005D0513-20070213
+#  EU decision 2006/771/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02008D0432-20080611
+# BG: https://crc.bg/files/_en/Electronic_Communications_Revised_EN1.pdf
+# BG: acceptance of 2006/771/EC https://crc.bg/files/Pravila_06_12_2018.pdf
+
 country BG: DFS-ETSI
 	# Wideband data transmission systems (WDTS) in the 2.4GHz ISM band, ref:
 	# I.22 of the List, BDS EN 300 328
-	(2402 - 2482 @ 40), (20)
+	(2400 - 2483.5 @ 40), (100 mW)
 	# 5 GHz Radio Local Area Networks (RLANs), ref:
 	# II.H01 of the List, BDS EN 301 893
-	(5170 - 5250 @ 80), (23), AUTO-BW, wmmrule=ETSI
-	(5250 - 5330 @ 80), (20), DFS, AUTO-BW, wmmrule=ETSI
+	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
+	(5250 - 5350 @ 80), (100 mW), NO-OUTDOOR, DFS, AUTO-BW, wmmrule=ETSI
 	# II.H01 of the List, I.54 from the List, BDS EN 301 893
-	(5490 - 5710 @ 160), (27), DFS, wmmrule=ETSI
-	# Short range devices (SRDs) in the 5725-5875 MHz frequency range, ref:
+	(5470 - 5725 @ 160), (500 mW), DFS, wmmrule=ETSI
+	# short range devices (ETSI EN 300 440-1)
 	# I.43 of the List, BDS EN 300 440-2, BDS EN 300 440-1
-	(5725 - 5875 @ 80), (14)
-	# 60 GHz Multiple-Gigabit RLAN Systems, ref:
+	(5725 - 5875 @ 80), (25 mW)
+	# 60 GHz band channels 1-4 (ETSI EN 302 567)
 	# II.H03 of the List, BDS EN 302 567-2
-	(57000 - 66000 @ 2160), (40), NO-OUTDOOR
-
+	(57000 - 66000 @ 2160), (40)
 country BH: DFS-JP
 	(2402 - 2482 @ 40), (20)
 	(5170 - 5250 @ 20), (20)
@@ -265,16 +290,23 @@ country CF: DFS-FCC
 	(5490 - 5730 @ 40), (24), DFS
 	(5735 - 5835 @ 40), (30)
 
-# Source:
-# https://www.ofcomnet.ch/#/fatTable
-# Note that the maximum transmitter power can be doubled for 5250-5710MHz if
-# transmitter power control is in use: 5250-5330@23db, 5490-5710@30db
+# CH as part of CEPT accepted decisions 2005/513/EC (5GHz RLAN, EN 301 893) 
+# and 2006/771/EC (amended by 2008/432/EC, Short-Range Devices, EN 300 440)
+#  EU decision 2005/513/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02005D0513-20070213
+#  EU decision 2006/771/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02008D0432-20080611
+# CH: https://www.ofcomnet.ch/api/rir/1010/05
+# CH: https://www.ofcomnet.ch/api/rir/1010/04
+# CH: https://www.ofcomnet.ch/api/rir/1008/12
+# CH: https://www.ofcomnet.ch/#/fatTable
 country CH: DFS-ETSI
-	(2402 - 2482 @ 40), (20)
-	(5150 - 5250 @ 80), (23), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
-	(5250 - 5350 @ 80), (20), NO-OUTDOOR, DFS, AUTO-BW, wmmrule=ETSI
-	(5490 - 5710 @ 160), (27), DFS, wmmrule=ETSI
-	# 60 GHz band channels 1-4, ref: Etsi En 302 567
+	(2400 - 2483.5 @ 40), (100 mW)
+	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
+	(5250 - 5350 @ 80), (100 mW), NO-OUTDOOR, DFS, AUTO-BW, wmmrule=ETSI
+	(5470 - 5725 @ 160), (500 mW), DFS, wmmrule=ETSI
+	# short range devices (ETSI EN 300 440-1)
+	(5725 - 5875 @ 80), (25 mW)
+	# 60 GHz band channels 1-4 (ETSI EN 302 567)
 	(57000 - 66000 @ 2160), (40)
 
 country CI: DFS-FCC
@@ -329,26 +361,43 @@ country CX: DFS-FCC
 	(5490 - 5730 @ 160), (24), DFS
 	(5735 - 5835 @ 80), (30)
 
+# CY as part of EU/CEPT accepted decisions 2005/513/EC (5GHz RLAN, EN 301 893) 
+# and 2006/771/EC (amended by 2008/432/EC, Short-Range Devices, EN 300 440)
+#  EU decision 2005/513/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02005D0513-20070213
+#  EU decision 2006/771/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02008D0432-20080611
+# CY: http://www.mcw.gov.cy/mcw/dec/dec.nsf/all/292484CFC7013DD4C2256EBA0023D447/$file/Sxedio%20Radiosyxnothtwn%20ths%20Dhmokratias-3-8-2018-E2.2(English%20Unified%20Unofficial).pdf?openelement
 country CY: DFS-ETSI
-	(2402 - 2482 @ 40), (20)
-	(5170 - 5250 @ 80), (20), AUTO-BW, wmmrule=ETSI
-	(5250 - 5330 @ 80), (20), DFS, AUTO-BW, wmmrule=ETSI
-	(5490 - 5710 @ 160), (27), DFS, wmmrule=ETSI
-	# 60 GHz band channels 1-4, ref: Etsi En 302 567
+	(2400 - 2483.5 @ 40), (100 mW)
+	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
+	(5250 - 5350 @ 80), (100 mW), NO-OUTDOOR, DFS, AUTO-BW, wmmrule=ETSI
+	(5470 - 5725 @ 160), (500 mW), DFS, wmmrule=ETSI
+	# short range devices (ETSI EN 300 440-1)
+	(5725 - 5875 @ 80), (25 mW)
+	# 60 GHz band channels 1-4 (ETSI EN 302 567)
 	(57000 - 66000 @ 2160), (40)
 
-# Data from http://www.ctu.eu/164/download/VOR/VOR-12-08-2005-34.pdf
-# and http://www.ctu.eu/164/download/VOR/VOR-12-05-2007-6-AN.pdf
-# Power at 5250 - 5350 MHz and 5470 - 5725 MHz can be doubled if TPC is
-# implemented.
+# CZ as part of EU/CEPT accepted decisions 2005/513/EC (5GHz RLAN, EN 301 893) 
+# and 2006/771/EC (amended by 2008/432/EC, Short-Range Devices, EN 300 440)
+#  EU decision 2005/513/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02005D0513-20070213
+#  EU decision 2006/771/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02008D0432-20080611
+# CZ: https://www.ctu.cz/cs/download/vseobecna-opravneni/archiv/vo-r_12-06_2010-09.pdf
+# CZ: https://www.ctu.cz/sites/default/files/obsah/ctu/vseobecne-opravneni-c.vo-r/10/12.2017-10/obrazky/vo-r10-122017-10.pdf
 country CZ: DFS-ETSI
 	(2400 - 2483.5 @ 40), (100 mW)
 	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
 	(5250 - 5350 @ 80), (100 mW), NO-OUTDOOR, DFS, AUTO-BW, wmmrule=ETSI
 	(5470 - 5725 @ 160), (500 mW), DFS, wmmrule=ETSI
-	# 60 GHz band channels 1-4, ref: Etsi En 302 567
+	# short range devices (ETSI EN 300 440-1)
+	(5725 - 5875 @ 80), (25 mW)
+	# 60 GHz band channels 1-4 (ETSI EN 302 567)
 	(57000 - 66000 @ 2160), (40)
 
+# DE as part of EU/CEPT accepted decisions 2005/513/EC (5GHz RLAN, EN 301 893) 
+# and 2006/771/EC (amended by 2008/432/EC, Short-Range Devices, EN 300 440)
+#  EU decision 2005/513/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02005D0513-20070213
+#  EU decision 2006/771/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02008D0432-20080611
+#
 # Allocation for the 2.4 GHz band (Vfg 10 / 2013, Allgemeinzuteilung von
 # Frequenzen für die Nutzung in lokalen Netzwerken; Wireless Local Area
 # Networks (WLAN-Funkanwendungen).
@@ -368,7 +417,6 @@ country CZ: DFS-ETSI
 # Bereich 57 GHz - 66 GHz für Funkanwendungen für weitbandige
 # Datenübertragungssysteme; „Multiple Gigabit WAS/RLAN Systems (MGWS)“).
 # https://www.bundesnetzagentur.de/SharedDocs/Downloads/DE/Sachgebiete/Telekommunikation/Unternehmen_Institutionen/Frequenzen/Allgemeinzuteilungen/2011_08_MGWS_pdf.pdf
-
 country DE: DFS-ETSI
 	(2400 - 2483.5 @ 40), (100 mW)
 	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
@@ -379,16 +427,22 @@ country DE: DFS-ETSI
 	# 60 GHz band channels 1-4 (ETSI EN 302 567)
 	(57000 - 66000 @ 2160), (40)
 
-# Sources:
+# DK as part of EU/CEPT accepted decisions 2005/513/EC (5GHz RLAN, EN 301 893) 
+# and 2006/771/EC (amended by 2008/432/EC, Short-Range Devices, EN 300 440)
+#  EU decision 2005/513/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02005D0513-20070213
+#  EU decision 2006/771/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02008D0432-20080611
+# DK: https://ens.dk/sites/ens.dk/files/Tele/frekvensplan_0.pdf
 # 5GHz: https://erhvervsstyrelsen.dk/sites/default/files/007_interface-datanet_5-6_ghz.pdf.pdf
 # 60GHz: https://erhvervsstyrelsen.dk/sites/default/files/radiograenseflader-63.pdf
 country DK: DFS-ETSI
-	(2400 - 2483.5 @ 40), (20)
-	(5150 - 5250 @ 80), (23), AUTO-BW, wmmrule=ETSI
-	(5250 - 5350 @ 80), (20), DFS, AUTO-BW, wmmrule=ETSI
-	(5470 - 5725 @ 160), (27), DFS, wmmrule=ETSI
+	(2400 - 2483.5 @ 40), (100 mW)
+	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
+	(5250 - 5350 @ 80), (100 mW), NO-OUTDOOR, DFS, AUTO-BW, wmmrule=ETSI
+	(5470 - 5725 @ 160), (500 mW), DFS, wmmrule=ETSI
+	# short range devices (ETSI EN 300 440-1)
+	(5725 - 5875 @ 80), (25 mW)
 	# 60 GHz band channels 1-4 (ETSI EN 302 567)
-	(57000 - 66000 @ 2160), (40), NO-OUTDOOR
+	(57000 - 66000 @ 2160), (40)
 
 # Source:
 # http://www.ntrcdom.org/index.php?option=com_content&view=category&layout=blog&id=10&Itemid=55
@@ -417,12 +471,20 @@ country EC: DFS-FCC
 	(5490 - 5730 @ 20), (24), DFS
 	(5735 - 5835 @ 20), (30)
 
+# EE as part of EU/CEPT accepted decisions 2005/513/EC (5GHz RLAN, EN 301 893) 
+# and 2006/771/EC (amended by 2008/432/EC, Short-Range Devices, EN 300 440)
+#  EU decision 2005/513/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02005D0513-20070213
+#  EU decision 2006/771/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02008D0432-20080611
+# EE: https://www.ttja.ee/et/ettevottele-organisatsioonile/sideteenused/raadioseadmed/wifi-seade
+# EE: https://www.itu.int/ITU-D/study_groups/SGP_1998-2002/JGRES09/pdf/estonia.pdf
 country EE: DFS-ETSI
-	(2402 - 2482 @ 40), (20)
-	(5170 - 5250 @ 80), (20), AUTO-BW, wmmrule=ETSI
-	(5250 - 5330 @ 80), (20), DFS, AUTO-BW, wmmrule=ETSI
-	(5490 - 5710 @ 160), (27), DFS, wmmrule=ETSI
-	# 60 GHz band channels 1-4, ref: Etsi En 302 567
+	(2400 - 2483.5 @ 40), (100 mW)
+	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
+	(5250 - 5350 @ 80), (100 mW), NO-OUTDOOR, DFS, AUTO-BW, wmmrule=ETSI
+	(5470 - 5725 @ 160), (500 mW), DFS, wmmrule=ETSI
+	# short range devices (ETSI EN 300 440-1)
+	(5725 - 5875 @ 80), (25 mW)
+	# 60 GHz band channels 1-4 (ETSI EN 302 567)
 	(57000 - 66000 @ 2160), (40)
 
 country EG: DFS-ETSI
@@ -430,17 +492,19 @@ country EG: DFS-ETSI
 	(5170 - 5250 @ 40), (20)
 	(5250 - 5330 @ 40), (20), DFS
 
-# Source:
-# Cuadro nacional de atribución de frecuencias (CNAF)
-# https://avancedigital.gob.es/espectro/Paginas/cnaf.aspx
+# ES as part of EU/CEPT accepted decisions 2005/513/EC (5GHz RLAN, EN 301 893) 
+# and 2006/771/EC (amended by 2008/432/EC, Short-Range Devices, EN 300 440)
+#  EU decision 2005/513/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02005D0513-20070213
+#  EU decision 2006/771/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02008D0432-20080611
+# ES: https://avancedigital.gob.es/espectro/Paginas/cnaf.aspx
 country ES: DFS-ETSI
 	(2400 - 2483.5 @ 40), (100 mW)
 	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
 	(5250 - 5350 @ 80), (100 mW), NO-OUTDOOR, DFS, AUTO-BW, wmmrule=ETSI
 	(5470 - 5725 @ 160), (500 mW), DFS, wmmrule=ETSI
-	# Short Range Devices (SRD) (ETSI EN 300 440)
+	# short range devices (ETSI EN 300 440-1)
 	(5725 - 5875 @ 80), (25 mW)
-	# 60 GHz band channels 1-4, ref: Etsi En 302 567
+	# 60 GHz band channels 1-4 (ETSI EN 302 567)
 	(57000 - 66000 @ 2160), (40)
 
 country ET: DFS-ETSI
@@ -449,14 +513,18 @@ country ET: DFS-ETSI
 	(5250 - 5330 @ 80), (20), DFS, AUTO-BW
 	(5490 - 5710 @ 160), (27), DFS
 
+# FI as part of EU/CEPT accepted decisions 2005/513/EC (5GHz RLAN, EN 301 893) 
+# and 2006/771/EC (amended by 2008/432/EC, Short-Range Devices, EN 300 440)
+#  EU decision 2005/513/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02005D0513-20070213
+#  EU decision 2006/771/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02008D0432-20080611
 country FI: DFS-ETSI
-	(2400 - 2483.5 @ 40), (20)
-	(5150 - 5250 @ 80), (23), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
-	(5250 - 5350 @ 80), (20), NO-OUTDOOR, DFS, AUTO-BW, wmmrule=ETSI
-	(5470 - 5725 @ 160), (27), DFS, wmmrule=ETSI
+	(2400 - 2483.5 @ 40), (100 mW)
+	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
+	(5250 - 5350 @ 80), (100 mW), NO-OUTDOOR, DFS, AUTO-BW, wmmrule=ETSI
+	(5470 - 5725 @ 160), (500 mW), DFS, wmmrule=ETSI
 	# short range devices (ETSI EN 300 440-1)
 	(5725 - 5875 @ 80), (25 mW)
-	# 60 GHz band channels 1-4, ref: Etsi En 302 567
+	# 60 GHz band channels 1-4 (ETSI EN 302 567)
 	(57000 - 66000 @ 2160), (40)
 
 country FM: DFS-FCC
@@ -466,22 +534,34 @@ country FM: DFS-FCC
 	(5490 - 5730 @ 160), (24), DFS
 	(5735 - 5835 @ 80), (30)
 
+# FR as part of EU/CEPT accepted decisions 2005/513/EC (5GHz RLAN, EN 301 893) 
+# and 2006/771/EC (amended by 2008/432/EC, Short-Range Devices, EN 300 440)
+#  EU decision 2005/513/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02005D0513-20070213
+#  EU decision 2006/771/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02008D0432-20080611
 country FR: DFS-ETSI
-	(2402 - 2482 @ 40), (20)
-	(5150 - 5250 @ 80), (23), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
-	(5250 - 5350 @ 80), (20), NO-OUTDOOR, DFS, AUTO-BW, wmmrule=ETSI
-	(5470 - 5725 @ 160), (27), DFS, wmmrule=ETSI
-        # short range devices (ETSI EN 300 440)
+	(2400 - 2483.5 @ 40), (100 mW)
+	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
+	(5250 - 5350 @ 80), (100 mW), NO-OUTDOOR, DFS, AUTO-BW, wmmrule=ETSI
+	(5470 - 5725 @ 160), (500 mW), DFS, wmmrule=ETSI
+	# short range devices (ETSI EN 300 440-1)
 	(5725 - 5875 @ 80), (25 mW)
-	# 60 GHz band channels 1-4, ref: Etsi En 302 567
+	# 60 GHz band channels 1-4 (ETSI EN 302 567)
 	(57000 - 66000 @ 2160), (40)
 
+# GB as part of EU/CEPT accepted decisions 2005/513/EC (5GHz RLAN, EN 301 893) 
+# and 2006/771/EC (amended by 2008/432/EC, Short-Range Devices, EN 300 440)
+#  EU decision 2005/513/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02005D0513-20070213
+#  EU decision 2006/771/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02008D0432-20080611
+# GB: https://www.ofcom.org.uk/__data/assets/pdf_file/0019/136009/Ofcom-Information-Sheet-5-GHz-RLANs.pdf
+# GB: https://www.ofcom.org.uk/__data/assets/pdf_file/0028/84970/ir-2030.pdf
 country GB: DFS-ETSI
-	(2402 - 2482 @ 40), (20)
-	(5170 - 5250 @ 80), (20), AUTO-BW, wmmrule=ETSI
-	(5250 - 5330 @ 80), (20), DFS, AUTO-BW, wmmrule=ETSI
-	(5490 - 5710 @ 160), (27), DFS, wmmrule=ETSI
-	# 60 GHz band channels 1-4, ref: Etsi En 302 567
+	(2400 - 2483.5 @ 40), (100 mW)
+	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
+	(5250 - 5350 @ 80), (100 mW), NO-OUTDOOR, DFS, AUTO-BW, wmmrule=ETSI
+	(5470 - 5725 @ 160), (500 mW), DFS, wmmrule=ETSI
+	# short range devices (ETSI EN 300 440-1)
+	(5725 - 5875 @ 80), (25 mW)
+	# 60 GHz band channels 1-4 (ETSI EN 302 567)
 	(57000 - 66000 @ 2160), (40)
 
 country GD: DFS-FCC
@@ -523,12 +603,20 @@ country GP: DFS-ETSI
 	(5250 - 5330 @ 80), (20), DFS, AUTO-BW, wmmrule=ETSI
 	(5490 - 5710 @ 160), (27), DFS, wmmrule=ETSI
 
+# GR as part of EU/CEPT accepted decisions 2005/513/EC (5GHz RLAN, EN 301 893) 
+# and 2006/771/EC (amended by 2008/432/EC, Short-Range Devices, EN 300 440)
+#  EU decision 2005/513/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02005D0513-20070213
+#  EU decision 2006/771/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02008D0432-20080611
+# GR: https://www.eett.gr/opencms/export/sites/default/EETT_EN/Electronic_Communications/Radio_Communications/TelecommunicationEquipment/Radio_equipment_interface_requirement_2012.pdf
+# GR: https://www.eett.gr/opencms/export/sites/default/EETT_EN/Electronic_Communications/Radio_Communications/TelecommunicationEquipment/Radio_equipment_interface_requirement_107.pdf
 country GR: DFS-ETSI
-	(2402 - 2482 @ 40), (20)
-	(5170 - 5250 @ 80), (20), AUTO-BW, wmmrule=ETSI
-	(5250 - 5330 @ 80), (20), DFS, AUTO-BW, wmmrule=ETSI
-	(5490 - 5710 @ 160), (27), DFS, wmmrule=ETSI
-	# 60 GHz band channels 1-4, ref: Etsi En 302 567
+	(2400 - 2483.5 @ 40), (100 mW)
+	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
+	(5250 - 5350 @ 80), (100 mW), NO-OUTDOOR, DFS, AUTO-BW, wmmrule=ETSI
+	(5470 - 5725 @ 160), (500 mW), DFS, wmmrule=ETSI
+	# short range devices (ETSI EN 300 440-1)
+	(5725 - 5875 @ 80), (25 mW)
+	# 60 GHz band channels 1-4 (ETSI EN 302 567)
 	(57000 - 66000 @ 2160), (40)
 
 country GT: DFS-FCC
@@ -563,11 +651,18 @@ country HN: DFS-FCC
 	(5735 - 5835 @ 80), (30)
 
 country HR: DFS-ETSI
-	(2400 - 2483.5 @ 40), (20)
-	(5150 - 5250 @ 80), (23), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
-	(5250 - 5350 @ 80), (20), NO-OUTDOOR, DFS, AUTO-BW, wmmrule=ETSI
-	(5470 - 5725 @ 160), (27), DFS, wmmrule=ETSI
-	# 60 GHz band channels 1-4, ref: Etsi En 302 567
+# HR as part of EU/CEPT accepted decisions 2005/513/EC (5GHz RLAN, EN 301 893) 
+# and 2006/771/EC (amended by 2008/432/EC, Short-Range Devices, EN 300 440)
+#  EU decision 2005/513/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02005D0513-20070213
+#  EU decision 2006/771/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02008D0432-20080611
+# HR: http://tablice.hakom.hr:8080/vis?lang=en
+	(2400 - 2483.5 @ 40), (100 mW)
+	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
+	(5250 - 5350 @ 80), (100 mW), NO-OUTDOOR, DFS, AUTO-BW, wmmrule=ETSI
+	(5470 - 5725 @ 160), (500 mW), DFS, wmmrule=ETSI
+	# short range devices (ETSI EN 300 440-1)
+	(5725 - 5875 @ 80), (25 mW)
+	# 60 GHz band channels 1-4 (ETSI EN 302 567)
 	(57000 - 66000 @ 2160), (40)
 
 country HT: DFS-FCC
@@ -577,37 +672,42 @@ country HT: DFS-FCC
 	(5490 - 5730 @ 160), (24), DFS
 	(5735 - 5835 @ 80), (30)
 
-# http://stir.nmhh.hu/?oldal=dokumentumGeneralo&root_rendeletelem_id=3&hatalyos=1
-# http://english.nmhh.hu/cikk/297/Eljarasi_tajekoztato_a_24_GHzes_es_az_5_GHzes_savban_mukodo_berendezesek_engedelyezeserol
-# http://nmhh.hu/dokumentum/319/kis_hatotavolsagu_eszkozok_srdk.pdf
+# HU as part of EU/CEPT accepted decisions 2005/513/EC (5GHz RLAN, EN 301 893) 
+# and 2006/771/EC (amended by 2008/432/EC, Short-Range Devices, EN 300 440)
+#  EU decision 2005/513/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02005D0513-20070213
+#  EU decision 2006/771/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02008D0432-20080611
+# HU: http://stir.nmhh.hu/?oldal=dokumentumGeneralo&root_rendeletelem_id=3&hatalyos=1
+# HU: http://english.nmhh.hu/cikk/297/Eljarasi_tajekoztato_a_24_GHzes_es_az_5_GHzes_savban_mukodo_berendezesek_engedelyezeserol
+# HU: http://nmhh.hu/dokumentum/319/kis_hatotavolsagu_eszkozok_srdk.pdf
 country HU: DFS-ETSI
-	# ref: 2006/771/EK, (EU) 2017/1483, MSZ EN 300 328
-	# additionally: 100mW @ 10MHz channels, 50mW @ 5MHz (max. 10mW/MHz)
-	(2400 - 2483.5 @ 40), (20)
-	# ref: 2005/513/EK
-	# note: TPC not needed @ 5150-5250
-	(5150 - 5250 @ 80), (23), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
-	# note: max would be +3dB with TPC @ 5250-5725
-	(5250 - 5350 @ 80), (20), NO-OUTDOOR, DFS, AUTO-BW, wmmrule=ETSI
-	(5470 - 5725 @ 160), (27), DFS, wmmrule=ETSI
-	# "Short Range Devices (SRD)"
-	# ref: 2006/771/EK, (EU) 2017/1483, MSZ EN 300 440, MSZ EN 302 064
+	(2400 - 2483.5 @ 40), (100 mW)
+	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
+	(5250 - 5350 @ 80), (100 mW), NO-OUTDOOR, DFS, AUTO-BW, wmmrule=ETSI
+	(5470 - 5725 @ 160), (500 mW), DFS, wmmrule=ETSI
+	# short range devices (ETSI EN 300 440-1)
 	(5725 - 5875 @ 80), (25 mW)
-	# 60 GHz band channels 1-4, "Fixed outdoor installation not allowed"
-	# ref: 2006/771/EK, (EU) 2017/1483, MSZ EN 302 567
-	(57000 - 66000 @ 2160), (40), NO-OUTDOOR
+	# 60 GHz band channels 1-4 (ETSI EN 302 567)
+	(57000 - 66000 @ 2160), (40)
 
 country ID: DFS-JP
 	# ref: http://www.postel.go.id/content/ID/regulasi/standardisasi/kepdir/bwa%205,8%20ghz.pdf
 	(2402 - 2482 @ 20), (20)
 	(5735 - 5815 @ 20), (23)
 
+# IE as part of EU/CEPT accepted decisions 2005/513/EC (5GHz RLAN, EN 301 893) 
+# and 2006/771/EC (amended by 2008/432/EC, Short-Range Devices, EN 300 440)
+#  EU decision 2005/513/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02005D0513-20070213
+#  EU decision 2006/771/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02008D0432-20080611
+# IE: https://www.comreg.ie/publication-download/interface-requirements-for-radio-services-in-ireland
+# IE: https://www.comreg.ie/publication-download/permitted-short-range-devices-ireland
 country IE: DFS-ETSI
-	(2402 - 2482 @ 40), (20)
-	(5170 - 5250 @ 80), (20), AUTO-BW, wmmrule=ETSI
-	(5250 - 5330 @ 80), (20), DFS, AUTO-BW, wmmrule=ETSI
-	(5490 - 5710 @ 160), (27), DFS, wmmrule=ETSI
-	# 60 GHz band channels 1-4, ref: Etsi En 302 567
+	(2400 - 2483.5 @ 40), (100 mW)
+	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
+	(5250 - 5350 @ 80), (100 mW), NO-OUTDOOR, DFS, AUTO-BW, wmmrule=ETSI
+	(5470 - 5725 @ 160), (500 mW), DFS, wmmrule=ETSI
+	# short range devices (ETSI EN 300 440-1)
+	(5725 - 5875 @ 80), (25 mW)
+	# 60 GHz band channels 1-4 (ETSI EN 302 567)
 	(57000 - 66000 @ 2160), (40)
 
 country IL: DFS-ETSI
@@ -626,20 +726,33 @@ country IR: DFS-JP
 	(2402 - 2482 @ 40), (20)
 	(5735 - 5835 @ 80), (30)
 
+# IS as part of CEPT accepted decisions 2005/513/EC (5GHz RLAN, EN 301 893) 
+# and 2006/771/EC (amended by 2008/432/EC, Short-Range Devices, EN 300 440)
+#  EU decision 2005/513/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02005D0513-20070213
+#  EU decision 2006/771/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02008D0432-20080611
+# IS: https://www.pfs.is/library/Skrar/Tidnir-og-taekni/MHZ_21022019.pdf
 country IS: DFS-ETSI
-	(2402 - 2482 @ 40), (20)
-	(5170 - 5250 @ 80), (20), AUTO-BW, wmmrule=ETSI
-	(5250 - 5330 @ 80), (20), DFS, AUTO-BW, wmmrule=ETSI
-	(5490 - 5710 @ 160), (27), DFS, wmmrule=ETSI
-	# 60 GHz band channels 1-4, ref: Etsi En 302 567
+	(2400 - 2483.5 @ 40), (100 mW)
+	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
+	(5250 - 5350 @ 80), (100 mW), NO-OUTDOOR, DFS, AUTO-BW, wmmrule=ETSI
+	(5470 - 5725 @ 160), (500 mW), DFS, wmmrule=ETSI
+	# short range devices (ETSI EN 300 440-1)
+	(5725 - 5875 @ 80), (25 mW)
+	# 60 GHz band channels 1-4 (ETSI EN 302 567)
 	(57000 - 66000 @ 2160), (40)
 
+# IT as part of EU/CEPT accepted decisions 2005/513/EC (5GHz RLAN, EN 301 893) 
+# and 2006/771/EC (amended by 2008/432/EC, Short-Range Devices, EN 300 440)
+#  EU decision 2005/513/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02005D0513-20070213
+#  EU decision 2006/771/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02008D0432-20080611
 country IT: DFS-ETSI
-	(2402 - 2482 @ 40), (20)
-	(5170 - 5250 @ 80), (20), AUTO-BW, wmmrule=ETSI
-	(5250 - 5330 @ 80), (20), DFS, AUTO-BW, wmmrule=ETSI
-	(5490 - 5710 @ 160), (27), DFS, wmmrule=ETSI
-	# 60 GHz band channels 1-4, ref: Etsi En 302 567
+	(2400 - 2483.5 @ 40), (100 mW)
+	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
+	(5250 - 5350 @ 80), (100 mW), NO-OUTDOOR, DFS, AUTO-BW, wmmrule=ETSI
+	(5470 - 5725 @ 160), (500 mW), DFS, wmmrule=ETSI
+	# short range devices (ETSI EN 300 440-1)
+	(5725 - 5875 @ 80), (25 mW)
+	# 60 GHz band channels 1-4 (ETSI EN 302 567)
 	(57000 - 66000 @ 2160), (40)
 
 country JM: DFS-FCC
@@ -741,16 +854,22 @@ country LC: DFS-ETSI
 	(5490 - 5710 @ 160), (30), DFS
 	(5735 - 5815 @ 80), (30)
 
-# Source:
-# https://www.ofcomnet.ch/#/fatTable
-# Note that the maximum transmitter power can be doubled for 5250-5710MHz if
-# transmitter power control is in use: 5250-5330@23db, 5490-5710@30db
+# LI as part of CEPT accepted decisions 2005/513/EC (5GHz RLAN, EN 301 893) 
+# and 2006/771/EC (amended by 2008/432/EC, Short-Range Devices, EN 300 440)
+#  EU decision 2005/513/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02005D0513-20070213
+#  EU decision 2006/771/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02008D0432-20080611
+# LI: https://www.ofcomnet.ch/api/rir/1010/05
+# LI: https://www.ofcomnet.ch/api/rir/1010/04
+# LI: https://www.ofcomnet.ch/api/rir/1008/12
+# LI: https://www.ofcomnet.ch/#/fatTable
 country LI: DFS-ETSI
-	(2402 - 2482 @ 40), (20)
-	(5150 - 5250 @ 80), (23), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
-	(5250 - 5350 @ 80), (20), NO-OUTDOOR, DFS, AUTO-BW, wmmrule=ETSI
-	(5490 - 5710 @ 160), (27), DFS, wmmrule=ETSI
-	# 60 GHz band channels 1-4, ref: Etsi En 302 567
+	(2400 - 2483.5 @ 40), (100 mW)
+	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
+	(5250 - 5350 @ 80), (100 mW), NO-OUTDOOR, DFS, AUTO-BW, wmmrule=ETSI
+	(5470 - 5725 @ 160), (500 mW), DFS, wmmrule=ETSI
+	# short range devices (ETSI EN 300 440-1)
+	(5725 - 5875 @ 80), (25 mW)
+	# 60 GHz band channels 1-4 (ETSI EN 302 567)
 	(57000 - 66000 @ 2160), (40)
 
 country LK: DFS-FCC
@@ -768,28 +887,50 @@ country LS: DFS-ETSI
 	(5250 - 5330 @ 80), (20), DFS, AUTO-BW
 	(5490 - 5710 @ 160), (27), DFS
 
+# LT as part of EU/CEPT accepted decisions 2005/513/EC (5GHz RLAN, EN 301 893) 
+# and 2006/771/EC (amended by 2008/432/EC, Short-Range Devices, EN 300 440)
+#  EU decision 2005/513/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02005D0513-20070213
+#  EU decision 2006/771/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02008D0432-20080611
+# LT: https://www.rrt.lt/en/radio-spectrum/frequency-management/ or direct link:
+# LT: https://www.e-tar.lt/portal/lt/legalAct/6e718fd037a011e69101aaab2992cbcd/dGRioCBBHb
 country LT: DFS-ETSI
-	(2402 - 2482 @ 40), (20)
-	(5170 - 5250 @ 80), (20), AUTO-BW, wmmrule=ETSI
-	(5250 - 5330 @ 80), (20), DFS, AUTO-BW, wmmrule=ETSI
-	(5490 - 5710 @ 160), (27), DFS, wmmrule=ETSI
-	# 60 GHz band channels 1-4, ref: Etsi En 302 567
+	(2400 - 2483.5 @ 40), (100 mW)
+	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
+	(5250 - 5350 @ 80), (100 mW), NO-OUTDOOR, DFS, AUTO-BW, wmmrule=ETSI
+	(5470 - 5725 @ 160), (500 mW), DFS, wmmrule=ETSI
+	# short range devices (ETSI EN 300 440-1)
+	(5725 - 5875 @ 80), (25 mW)
+	# 60 GHz band channels 1-4 (ETSI EN 302 567)
 	(57000 - 66000 @ 2160), (40)
 
+# LU as part of EU/CEPT accepted decisions 2005/513/EC (5GHz RLAN, EN 301 893) 
+# and 2006/771/EC (amended by 2008/432/EC, Short-Range Devices, EN 300 440)
+#  EU decision 2005/513/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02005D0513-20070213
+#  EU decision 2006/771/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02008D0432-20080611
+# LU: https://assets.ilr.lu/frequences/Documents/ILRLU-1723895916-183.pdf#search=en%20300%20440
 country LU: DFS-ETSI
-	(2402 - 2482 @ 40), (20)
-	(5170 - 5250 @ 80), (20), AUTO-BW, wmmrule=ETSI
-	(5250 - 5330 @ 80), (20), DFS, AUTO-BW, wmmrule=ETSI
-	(5490 - 5710 @ 160), (27), DFS, wmmrule=ETSI
-	# 60 GHz band channels 1-4, ref: Etsi En 302 567
+	(2400 - 2483.5 @ 40), (100 mW)
+	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
+	(5250 - 5350 @ 80), (100 mW), NO-OUTDOOR, DFS, AUTO-BW, wmmrule=ETSI
+	(5470 - 5725 @ 160), (500 mW), DFS, wmmrule=ETSI
+	# short range devices (ETSI EN 300 440-1)
+	(5725 - 5875 @ 80), (25 mW)
+	# 60 GHz band channels 1-4 (ETSI EN 302 567)
 	(57000 - 66000 @ 2160), (40)
-
+	
+# LV as part of EU/CEPT accepted decisions 2005/513/EC (5GHz RLAN, EN 301 893) 
+# and 2006/771/EC (amended by 2008/432/EC, Short-Range Devices, EN 300 440)
+#  EU decision 2005/513/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02005D0513-20070213
+#  EU decision 2006/771/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02008D0432-20080611
+# LV: http://likumi.lv/doc.php?id=198903
 country LV: DFS-ETSI
-	(2402 - 2482 @ 40), (20)
-	(5170 - 5250 @ 80), (20), AUTO-BW, wmmrule=ETSI
-	(5250 - 5330 @ 80), (20), DFS, AUTO-BW, wmmrule=ETSI
-	(5490 - 5710 @ 160), (27), DFS, wmmrule=ETSI
-	# 60 GHz band channels 1-4, ref: Etsi En 302 567
+	(2400 - 2483.5 @ 40), (100 mW)
+	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
+	(5250 - 5350 @ 80), (100 mW), NO-OUTDOOR, DFS, AUTO-BW, wmmrule=ETSI
+	(5470 - 5725 @ 160), (500 mW), DFS, wmmrule=ETSI
+	# short range devices (ETSI EN 300 440-1)
+	(5725 - 5875 @ 80), (25 mW)
+	# 60 GHz band channels 1-4 (ETSI EN 302 567)
 	(57000 - 66000 @ 2160), (40)
 
 country MA: DFS-ETSI
@@ -875,12 +1016,19 @@ country MR: DFS-ETSI
 	(5250 - 5330 @ 80), (20), DFS, AUTO-BW
 	(5490 - 5710 @ 160), (27), DFS
 
+# MT as part of EU/CEPT accepted decisions 2005/513/EC (5GHz RLAN, EN 301 893) 
+# and 2006/771/EC (amended by 2008/432/EC, Short-Range Devices, EN 300 440)
+#  EU decision 2005/513/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02005D0513-20070213
+#  EU decision 2006/771/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02008D0432-20080611
+# MT: https://www.mca.org.mt/sites/default/files/NFP_edition%206-1.pdf
 country MT: DFS-ETSI
-	(2402 - 2482 @ 40), (20)
-	(5170 - 5250 @ 80), (20), AUTO-BW, wmmrule=ETSI
-	(5250 - 5330 @ 80), (20), DFS, AUTO-BW, wmmrule=ETSI
-	(5490 - 5710 @ 160), (27), DFS, wmmrule=ETSI
-	# 60 GHz band channels 1-4, ref: Etsi En 302 567
+	(2400 - 2483.5 @ 40), (100 mW)
+	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
+	(5250 - 5350 @ 80), (100 mW), NO-OUTDOOR, DFS, AUTO-BW, wmmrule=ETSI
+	(5470 - 5725 @ 160), (500 mW), DFS, wmmrule=ETSI
+	# short range devices (ETSI EN 300 440-1)
+	(5725 - 5875 @ 80), (25 mW)
+	# 60 GHz band channels 1-4 (ETSI EN 302 567)
 	(57000 - 66000 @ 2160), (40)
 
 country MU: DFS-FCC
@@ -930,34 +1078,36 @@ country NI: DFS-FCC
 	(5490 - 5730 @ 160), (24), DFS
 	(5735 - 5835 @ 80), (30)
 
-# Regulation on the use of frequency space without a license and
-# without notification 2015
-#
-# http://wetten.overheid.nl/BWBR0036378/2015-03-05
-
+# NL as part of EU/CEPT accepted decisions 2005/513/EC (5GHz RLAN, EN 301 893) 
+# and 2006/771/EC (amended by 2008/432/EC, Short-Range Devices, EN 300 440)
+#  EU decision 2005/513/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02005D0513-20070213
+#  EU decision 2006/771/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02008D0432-20080611
+# NL: http://wetten.overheid.nl/BWBR0036378/2015-03-05
 country NL: DFS-ETSI
-	(2402 - 2482 @ 40), (20)
-	(5170 - 5250 @ 80), (20), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
-	(5250 - 5330 @ 80), (20), NO-OUTDOOR, DFS, AUTO-BW, wmmrule=ETSI
-	(5490 - 5710 @ 160), (27), DFS, wmmrule=ETSI
+	(2400 - 2483.5 @ 40), (100 mW)
+	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
+	(5250 - 5350 @ 80), (100 mW), NO-OUTDOOR, DFS, AUTO-BW, wmmrule=ETSI
+	(5470 - 5725 @ 160), (500 mW), DFS, wmmrule=ETSI
 	# short range devices (ETSI EN 300 440-1)
 	(5725 - 5875 @ 80), (25 mW)
-	# 60 GHz band channels 1-4, ref: Etsi En 302 567
+	# 60 GHz band channels 1-4 (ETSI EN 302 567)
 	(57000 - 66000 @ 2160), (40)
 
-# Data from http://www.lovdata.no/dokument/SF/forskrift/2012-01-19-77
-# Power at 5250 - 5350 MHz, 5470 - 5725 MHz and 5815 – 5850 MHz can
-# be doubled if TPC is implemented.
-# Up to 2W (or 4W with TPC) is allowed in the 5725 – 5795 MHz band
-# which has been merged with 5470 - 5725 MHz to allow wide channels
+# NO as part of CEPT accepted decisions 2005/513/EC (5GHz RLAN, EN 301 893) 
+# and 2006/771/EC (amended by 2008/432/EC, Short-Range Devices, EN 300 440)
+#  EU decision 2005/513/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02005D0513-20070213
+#  EU decision 2006/771/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02008D0432-20080611
+# NO: https://eng.nkom.no/technical/temporary-licenses/mobile-videolink/wireless-cameras-mobile-video-links/_attachment/9947
+# NO: http://www.lovdata.no/dokument/SF/forskrift/2012-01-19-77
+# In addition to EU NO can use 5725–5795 MHz and 5815–5850 bands with limit of 4 W EIRP (with DFS and TPC)
 country NO: DFS-ETSI
 	(2400 - 2483.5 @ 40), (100 mW)
-	(5150 - 5250 @ 80), (200 mW), AUTO-BW, wmmrule=ETSI
-	(5250 - 5350 @ 80), (100 mW), DFS, AUTO-BW, wmmrule=ETSI
-	(5470 - 5795 @ 160), (500 mW), DFS, wmmrule=ETSI
-	(5815 - 5850 @ 35), (2000 mW), DFS
-	(17100 - 17300 @ 200), (100 mW)
-	# 60 GHz band channels 1-4, ref: Etsi En 302 567
+	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
+	(5250 - 5350 @ 80), (100 mW), NO-OUTDOOR, DFS, AUTO-BW, wmmrule=ETSI
+	(5470 - 5725 @ 160), (500 mW), DFS, wmmrule=ETSI
+	# short range devices (ETSI EN 300 440-1)
+	(5725 - 5875 @ 80), (25 mW)
+	# 60 GHz band channels 1-4 (ETSI EN 302 567)
 	(57000 - 66000 @ 2160), (40)
 
 country NP: DFS-JP
@@ -1020,12 +1170,18 @@ country PK: DFS-JP
 	(2402 - 2482 @ 40), (20)
 	(5735 - 5835 @ 80), (30)
 
+# PL as part of EU/CEPT accepted decisions 2005/513/EC (5GHz RLAN, EN 301 893) 
+# and 2006/771/EC (amended by 2008/432/EC, Short-Range Devices, EN 300 440)
+#  EU decision 2005/513/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02005D0513-20070213
+#  EU decision 2006/771/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02008D0432-20080611
 country PL: DFS-ETSI
-	(2402 - 2482 @ 40), (20)
-	(5170 - 5250 @ 80), (20), AUTO-BW, wmmrule=ETSI
-	(5250 - 5330 @ 80), (20), DFS, AUTO-BW, wmmrule=ETSI
-	(5490 - 5710 @ 160), (27), DFS, wmmrule=ETSI
-	# 60 GHz band channels 1-4, ref: Etsi En 302 567
+	(2400 - 2483.5 @ 40), (100 mW)
+	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
+	(5250 - 5350 @ 80), (100 mW), NO-OUTDOOR, DFS, AUTO-BW, wmmrule=ETSI
+	(5470 - 5725 @ 160), (500 mW), DFS, wmmrule=ETSI
+	# short range devices (ETSI EN 300 440-1)
+	(5725 - 5875 @ 80), (25 mW)
+	# 60 GHz band channels 1-4 (ETSI EN 302 567)
 	(57000 - 66000 @ 2160), (40)
 
 country PM: DFS-ETSI
@@ -1041,14 +1197,19 @@ country PR: DFS-FCC
 	(5490 - 5730 @ 160), (24), DFS
 	(5735 - 5835 @ 80), (30)
 
+# PT as part of EU/CEPT accepted decisions 2005/513/EC (5GHz RLAN, EN 301 893) 
+# and 2006/771/EC (amended by 2008/432/EC, Short-Range Devices, EN 300 440)
+#  EU decision 2005/513/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02005D0513-20070213
+#  EU decision 2006/771/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02008D0432-20080611
+# PT: https://www.anacom.pt/render.jsp?categoryId=336334
 country PT: DFS-ETSI
-	(2402 - 2482 @ 40), (20)
-	(5170 - 5250 @ 80), (20), AUTO-BW, wmmrule=ETSI
-	(5250 - 5330 @ 80), (20), DFS, AUTO-BW, wmmrule=ETSI
-	(5490 - 5710 @ 160), (27), DFS, wmmrule=ETSI
+	(2400 - 2483.5 @ 40), (100 mW)
+	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
+	(5250 - 5350 @ 80), (100 mW), NO-OUTDOOR, DFS, AUTO-BW, wmmrule=ETSI
+	(5470 - 5725 @ 160), (500 mW), DFS, wmmrule=ETSI
 	# short range devices (ETSI EN 300 440-1)
 	(5725 - 5875 @ 80), (25 mW)
-	# 60 GHz band channels 1-4, ref: Etsi En 302 567
+	# 60 GHz band channels 1-4 (ETSI EN 302 567)
 	(57000 - 66000 @ 2160), (40)
 
 country PW: DFS-FCC
@@ -1079,15 +1240,21 @@ country RE: DFS-ETSI
 	(5250 - 5330 @ 80), (20), DFS, AUTO-BW, wmmrule=ETSI
 	(5490 - 5710 @ 160), (27), DFS, wmmrule=ETSI
 
+# RO as part of EU/CEPT accepted decisions 2005/513/EC (5GHz RLAN, EN 301 893) 
+# and 2006/771/EC (amended by 2008/432/EC, Short-Range Devices, EN 300 440)
+#  EU decision 2005/513/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02005D0513-20070213
+#  EU decision 2006/771/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02008D0432-20080611
+# RO: http://www.ancom.org.ro/en/uploads/links_files/ordin_262_2006.pdf
 country RO: DFS-ETSI
-	(2402 - 2482 @ 40), (20)
-	(5170 - 5250 @ 80), (20), AUTO-BW, wmmrule=ETSI
-	(5250 - 5330 @ 80), (20), DFS, AUTO-BW, wmmrule=ETSI
-	(5490 - 5710 @ 160), (27), DFS, wmmrule=ETSI
-	# 60 GHz band channels 1-4, ref: Etsi En 302 567
+	(2400 - 2483.5 @ 40), (100 mW)
+	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
+	(5250 - 5350 @ 80), (100 mW), NO-OUTDOOR, DFS, AUTO-BW, wmmrule=ETSI
+	(5470 - 5725 @ 160), (500 mW), DFS, wmmrule=ETSI
+	# short range devices (ETSI EN 300 440-1)
+	(5725 - 5875 @ 80), (25 mW)
+	# 60 GHz band channels 1-4 (ETSI EN 302 567)
 	(57000 - 66000 @ 2160), (40)
 
-
 # Source:
 # http://www.ratel.rs/upload/documents/Plan_namene/Plan_namene-sl_glasnik.pdf
 country RS: DFS-ETSI
@@ -1119,18 +1286,20 @@ country SA: DFS-ETSI
 	(5250 - 5330 @ 80), (20), DFS, AUTO-BW
 	(5490 - 5710 @ 160), (27), DFS
 
-# Source:
-# https://pts.se/globalassets/startpage/dokument/legala-dokument/foreskrifter/radio/beslutade_ptsfs-2018-3-undantagsforeskrifter.pdf
+# SE as part of EU/CEPT accepted decisions 2005/513/EC (5GHz RLAN, EN 301 893) 
+# and 2006/771/EC (amended by 2008/432/EC, Short-Range Devices, EN 300 440)
+#  EU decision 2005/513/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02005D0513-20070213
+#  EU decision 2006/771/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02008D0432-20080611
+# SE: https://pts.se/globalassets/startpage/dokument/legala-dokument/foreskrifter/radio/beslutade_ptsfs-2018-3-undantagsforeskrifter.pdf
 country SE: DFS-ETSI
-	(2400 - 2483.5 @ 40), (20)
-	(5150 - 5250 @ 80), (23), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
-	# note: max would be +3dB with TPC @ 5250-5725
-	(5250 - 5350 @ 80), (20), NO-OUTDOOR, DFS, AUTO-BW, wmmrule=ETSI
-	(5470 - 5725 @ 160), (27), DFS, wmmrule=ETSI
-	# short range devices (ETSI EN 300 440)
+	(2400 - 2483.5 @ 40), (100 mW)
+	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
+	(5250 - 5350 @ 80), (100 mW), NO-OUTDOOR, DFS, AUTO-BW, wmmrule=ETSI
+	(5470 - 5725 @ 160), (500 mW), DFS, wmmrule=ETSI
+	# short range devices (ETSI EN 300 440-1)
 	(5725 - 5875 @ 80), (25 mW)
-	# 60 GHz band channels 1-4, ref: Etsi En 302 567
-	(57000 - 66000 @ 2160), (40), NO-OUTDOOR
+	# 60 GHz band channels 1-4 (ETSI EN 302 567)
+	(57000 - 66000 @ 2160), (40)
 
 # Source
 # https://www.imda.gov.sg/~/media/imda/files/regulation%20licensing%20and%20consultations/ict%20standards/telecommunication%20standards/radio-comms/imdatssrd.pdf?la=en
@@ -1144,20 +1313,36 @@ country SG: DFS-FCC
 	# (5470 - 5725 @ 160), (30), DFS
 	(5725 - 5850 @ 80), (30)
 
+# SI as part of EU/CEPT accepted decisions 2005/513/EC (5GHz RLAN, EN 301 893) 
+# and 2006/771/EC (amended by 2008/432/EC, Short-Range Devices, EN 300 440)
+#  EU decision 2005/513/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02005D0513-20070213
+#  EU decision 2006/771/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02008D0432-20080611
+# SI: https://www.akos-rs.si/bwa
 country SI: DFS-ETSI
-	(2402 - 2482 @ 40), (20)
-	(5170 - 5250 @ 80), (20), AUTO-BW, wmmrule=ETSI
-	(5250 - 5330 @ 80), (20), DFS, AUTO-BW, wmmrule=ETSI
-	(5490 - 5710 @ 160), (27), DFS, wmmrule=ETSI
-	# 60 GHz band channels 1-4, ref: Etsi En 302 567
+	(2400 - 2483.5 @ 40), (100 mW)
+	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
+	(5250 - 5350 @ 80), (100 mW), NO-OUTDOOR, DFS, AUTO-BW, wmmrule=ETSI
+	(5470 - 5725 @ 160), (500 mW), DFS, wmmrule=ETSI
+	# short range devices (ETSI EN 300 440-1)
+	(5725 - 5875 @ 80), (25 mW)
+	# 60 GHz band channels 1-4 (ETSI EN 302 567)
 	(57000 - 66000 @ 2160), (40)
 
+# SK as part of EU/CEPT accepted decisions 2005/513/EC (5GHz RLAN, EN 301 893) 
+# and 2006/771/EC (amended by 2008/432/EC, Short-Range Devices, EN 300 440)
+#  EU decision 2005/513/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02005D0513-20070213
+#  EU decision 2006/771/EC: https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02008D0432-20080611
+# SK: https://www.teleoff.gov.sk/data/files/25911.pdf
+# SK: https://www.teleoff.gov.sk/data/files/41072.pdf
+# SK: https://www.teleoff.gov.sk/data/files/49125_vpr-01_2018-rusi-vpr-10_2014a21_2012-nespecifik-srd_021018.pdf
 country SK: DFS-ETSI
-	(2402 - 2482 @ 40), (20)
-	(5170 - 5250 @ 80), (20), AUTO-BW, wmmrule=ETSI
-	(5250 - 5330 @ 80), (20), DFS, AUTO-BW, wmmrule=ETSI
-	(5490 - 5710 @ 160), (27), DFS, wmmrule=ETSI
-	# 60 GHz band channels 1-4, ref: Etsi En 302 567
+	(2400 - 2483.5 @ 40), (100 mW)
+	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=ETSI
+	(5250 - 5350 @ 80), (100 mW), NO-OUTDOOR, DFS, AUTO-BW, wmmrule=ETSI
+	(5470 - 5725 @ 160), (500 mW), DFS, wmmrule=ETSI
+	# short range devices (ETSI EN 300 440-1)
+	(5725 - 5875 @ 80), (25 mW)
+	# 60 GHz band channels 1-4 (ETSI EN 302 567)
 	(57000 - 66000 @ 2160), (40)
 
 # Source:

